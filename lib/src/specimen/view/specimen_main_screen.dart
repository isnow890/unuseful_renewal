import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/specimen/model/specimen_model.dart';
import 'package:unuseful/src/specimen/provider/specimenSearchValueProvider.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/custom_readonly_search_text_field.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

import '../../../theme/component/button/button.dart';
import '../../../theme/component/section_card.dart';
import '../../../theme/component/segment_button.dart';
import '../../../theme/component/toast/toast.dart';
import '../../home/model/search_history_main_model.dart';
import '../../home/provider/specimen_history_provider.dart';
import '../component/specimen_main_screen_expansion_panel_list.dart';
import '../model/specimen_params.dart';
import '../provider/specimen_provider.dart';
import '../provider/specimen_state_provider.dart';
import '../repository/specimen_repository.dart';
import 'specimen_result_screen.dart';
import 'specimen_search_screen.dart';

class SpecimenMainScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimenMain';

  const SpecimenMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SpecimenMainScreen> createState() => _SpecimenMainScreenState();
}

class _SpecimenMainScreenState extends ConsumerState<SpecimenMainScreen> {
  DateTime? rangeStart = DateTime(
      DateTime.now().year, DateTime.now().month - 6, DateTime.now().day);
  DateTime? rangeEnd =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // DateTime? selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  int hspType = 0;
  int searchType = 0;
  int textFormFieldMaxLength = 8;
  String? textFormFieldText;

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  // final textFormFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // textFormFieldController.addListener(_getTextFormFieldText);
  }

  void _getTextFormFieldText() {
    // textFormFieldText = textFormFieldController.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // textFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    final state = ref.watch(specimenStateProvider);
    final search = ref.watch(specimenSearchValueProvider);

    final TextStyle segmentTextStyle = const TextStyle(
      fontSize: 15.0,
    );

    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      //테두리 깍기

      borderRadius: BorderRadius.circular(6.0),
    );

    if (state is SpecimenModelError) {
      return DefaultLayout(
        child: CustomErrorWidget(
          message: state.message,
          onPressed: () {},
        ),
        title: 'specimen',
      );
    }

    // if (state is SpecimenModel) {
    //   print('yes');
    //   if (state.data!.length == 0) {
    //     showToast(msg: '데이터가 없습니다.');
    //   } else {}
    // }

    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: _barcodeOnpressed,
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.barcode_reader,
          size: 30,
        ),
      ),
      title: 'specimen',
      child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            //드래그 하면 키보드 집어넣기.
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '병원',
                    style: theme.typo.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SegmentButton(
                    selectionIndex: hspType,
                    onSegmentTapped: (index) {
                      setState(() {
                        hspType = index;
                      });
                    },
                    children: {
                      0: Text('전체', style: segmentTextStyle),
                      1: Text(
                        '서울',
                        style: segmentTextStyle,
                      ),
                      2: Text(
                        '목동',
                        style: segmentTextStyle,
                      )
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Text(
                    '등록번호 또는 검체번호',
                    style: theme.typo.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // _renderSpecimenNoOrPatientNoSegmentHelper(segmentTextStyle),

                  CustomReadOnlySearchTextField(
                      hintText: '등록번호/검체번호',
                      searchType: searchType.toString(),
                      push: SpecimenSearchScreen.routeName,
                      provider: specimenSearchValueProvider),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '조회 기간',
                    style: theme.typo.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SpecimenMainScreenExpansionPanelList(
                    searchType: searchType,
                    rangeStart: rangeStart,
                    rangeEnd: rangeEnd,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Button(
                      text: '조회',
                      width: double.infinity,
                      color: theme.color.onPrimary,
                      backgroundColor: theme.color.primary,
                      onPressed: state is SpecimenModelLoading
                          ? null
                          : () async {
                        if (!_validateBeforeSearch(search.length))
                          return;
                        final data = await _getData(search);

                        final body = SearchHistoryModel(
                            lastUpdated: DateTime.now(),
                            searchValue: search,
                            mode: '');
                        await ref
                            .read(specimenHistoryNotfierProvider
                            .notifier)
                            .saveSpecimenHistory(body: body);

                        if (data!.isEmpty) {
                          showToast(msg: '데이터가 없습니다.');
                        } else {
                          context.pushNamed(
                              SpecimenResultScreen.routeName,
                              extra: SpecimenParams(
                                  hspTpCd: _getHspTpCd(),
                                  searchValue: search,
                                  strDt: DateFormat('yyyyMMdd')
                                      .format(rangeStart!),
                                  endDt: DateFormat('yyyyMMdd')
                                      .format(rangeEnd!),
                                  orderBy: 'desc'));
                        }
                      }
                  ),
                  // Row(
                  //   children: [
                  //
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: state is SpecimenModelLoading
                  //             ? null
                  //             : () async {
                  //                 if (!_validateBeforeSearch(search.length))
                  //                   return;
                  //                 final data = await _getData(search);
                  //
                  //                 final body = SearchHistoryModel(
                  //                     lastUpdated: DateTime.now(),
                  //                     searchValue: search,
                  //                     mode: '');
                  //                 await ref
                  //                     .read(specimenHistoryNotfierProvider
                  //                         .notifier)
                  //                     .saveSpecimenHistory(body: body);
                  //
                  //                 if (data!.isEmpty) {
                  //                   showToast(msg: '데이터가 없습니다.');
                  //                 } else {
                  //                   context.pushNamed(
                  //                       SpecimenResultScreen.routeName,
                  //                       extra: SpecimenParams(
                  //                           hspTpCd: _getHspTpCd(),
                  //                           searchValue: search,
                  //                           strDt: DateFormat('yyyyMMdd')
                  //                               .format(rangeStart!),
                  //                           endDt: DateFormat('yyyyMMdd')
                  //                               .format(rangeEnd!),
                  //                           orderBy: 'desc'));
                  //                 }
                  //               },
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: PRIMARY_COLOR,
                  //         ),
                  //         child: state is! SpecimenModelLoading
                  //             ? const Text('조회')
                  //             : Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: const [
                  //                     SizedBox(
                  //                       width: 12,
                  //                       height: 12,
                  //                       child: CircularProgressIndicator(
                  //                         strokeWidth: 2,
                  //                         color: Colors.black,
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Text('조회')
                  //                   ]),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )),
    );
  }

  Future<List<SpecimenPrimaryModel>?> _getData(searcn) async {
    ref
        .read(specimenStateProvider.notifier)
        .update((state) => SpecimenModelLoading());

    try {
      final repository = SpecimenRepository(ref.read(dioProvider), baseUrl: ip);
      final result = await repository.getSpcmInformation(
          specimenParams: SpecimenParams(
              hspTpCd: _getHspTpCd(),
              searchValue: searcn,
              strDt: DateFormat('yyyyMMdd').format(rangeStart!),
              endDt: DateFormat('yyyyMMdd').format(rangeEnd!),
              orderBy: 'desc'));

      ref
          .read(specimenStateProvider.notifier)
          .update((state) => SpecimenModel(data: result));

      return result;
    } catch (e) {
      print(e.toString());
      ref
          .read(specimenStateProvider.notifier)
          .update((state) => SpecimenModelError(message: '에러가 발생하였습니다.'));
    }
  }

  String _getHspTpCd() {
    switch (hspType) {
      case 0:
        return 'all';
      default:
        return '0$hspType';
    }
  }

  bool _validateBeforeSearch(search) {
    if (searchType == 1) {
      if (search != 11) {
        Toast.show('11자리의 검체번호를 입력하세요');
        return false;
      }
    }
    if (searchType == 0) {
      if (search != 8) {
        Toast.show('8자리의 등록번호를 입력하세요.');
        return false;
      }
    }
    return true;
  }

  _barcodeOnpressed() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', '취소', true, ScanMode.BARCODE);
    print(barcodeScanRes);

    if (barcodeScanRes.length != 11) {
      showToast(msg: '11자리의 검체번호를 스캔해주세요.');
      return;
    }

    // ref.read(specimenFamilyProvider(SpecimenParams(
    //     searchValue: barcodeScanRes,
    //     strDt: DateFormat('yyyyMMdd').format(rangeStart!),
    //     endDt: DateFormat('yyyyMMdd').format(rangeEnd!),
    //     orderBy: 'desc',
    //     hspTpCd: _getHspTpCd())));
  }

  _renderHosiptalSegmentHelper(segmentTextStyle) {
    return Row(
      children: [
        Expanded(
          child: MaterialSegmentedControl(
            children: {
              0: Text('전체', style: segmentTextStyle),
              1: Text(
                '서울',
                style: segmentTextStyle,
              ),
              2: Text(
                '목동',
                style: segmentTextStyle,
              )
            },
            horizontalPadding: const EdgeInsets.all(0),
            selectionIndex: hspType,
            borderColor: Colors.grey,
            selectedColor: PRIMARY_COLOR,
            unselectedColor: Colors.white,
            selectedTextStyle: TextStyle(color: Colors.white),
            unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
            borderWidth: 0.7,
            borderRadius: 6.0,
            verticalOffset: 8.0,
            onSegmentTapped: (index) {
              setState(() {
                hspType = index;
              });
            },
          ),
        ),
      ],
    );
  }

}
