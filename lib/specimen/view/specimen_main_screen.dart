import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/specimen/model/specimen_model.dart';
import 'package:unuseful/specimen/provider/specimen_variable_provider.dart';
import 'package:unuseful/specimen/view/specimen_result_screen.dart';

import '../../common/component/custom_error_widget.dart';
import '../../common/component/custom_text_form_field.dart';
import '../../common/component/general_toast_message.dart';
import '../../common/const/data.dart';
import '../component/specimen_main_screen_expansion_panel_list.dart';
import '../model/specimen_params.dart';
import '../provider/specimen_provider.dart';
import '../provider/specimen_state_provider.dart';
import '../repository/specimen_repository.dart';

class SpecimenMainScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimenMain';

  const SpecimenMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SpecimenMainScreen> createState() => _SpecimenMainScreenState();
}

class _SpecimenMainScreenState extends ConsumerState<SpecimenMainScreen> {
  DateTime? rangeStart = new DateTime(
      DateTime.now().year, DateTime.now().month - 6, DateTime.now().day);
  DateTime? rangeEnd = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // DateTime? selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  int hspType = 0;
  int searchType = 0;
  int textFormFieldMaxLength = 8;
  String? textFormFieldText;

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  final textFormFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFormFieldController.addListener(_getTextFormFieldText);
  }

  void _getTextFormFieldText() {
    textFormFieldText = textFormFieldController.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(specimenStateProvider);

    final TextStyle segmentTextStyle = const TextStyle(
      fontSize: 12.0,
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
          onPressed: () {
            print('실행');


          },
        ),
        title: Text('specimen'),
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
      title: Text('specimen'),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          //드래그 하면 키보드 집어넣기.
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                //모서리를 둥글게 하기 위해 사용
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 6.0, //그림자 깊이
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    _renderTitleTextHelper('병원구분'),
                    _renderHosiptalSegmentHelper(segmentTextStyle),
                    const Divider(
                      height: 30,
                    ),
                    _renderTitleTextHelper('등록번호/검체번호'),
                    _renderSpecimenNoOrPatientNoSegmentHelper(segmentTextStyle),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: CustomTextFormField(
                              hintText: searchType == 0
                                  ? '8자리의 등록번호를 입력하세요.'
                                  : '11자리의 검체번호를 입력하세요.',
                              isSuffixDeleteButtonEnabled: true,
                              controller: textFormFieldController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(
                                    textFormFieldMaxLength),
                              ],
                              contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 30,
                    ),
                    _renderTitleTextHelper('조회 기간'),
                    SpecimenMainScreenExpansionPanelList(
                      searchType: searchType,
                      rangeStart: rangeStart,
                      rangeEnd: rangeEnd,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: state is SpecimenModelLoading
                                ? null
                                : () async {
                                    if (!_validateBeforeSearch()) return;
                                    final data = await _getData();
                                    if (data!.isEmpty) {
                                      showToast(msg: '데이터가 없습니다.');
                                    } else {
                                      context.pushNamed(
                                          SpecimenResultScreen.routeName,
                                          extra: SpecimenParams(
                                              hspTpCd: _getHspTpCd(),
                                              searchValue:
                                                  textFormFieldController.text,
                                              strDt: DateFormat('yyyyMMdd')
                                                  .format(rangeStart!),
                                              endDt: DateFormat('yyyyMMdd')
                                                  .format(rangeEnd!),
                                              orderBy: 'desc'));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY_COLOR,
                            ),
                            child: state is! SpecimenModelLoading
                                ? const Text('조회')
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                        SizedBox(
                                          width: 12,
                                          height: 12,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('조회')
                                      ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _renderDefaultLayOut({required Widget widget}) {
    return DefaultLayout(
      title: Text('specimen'),
      child: widget,
    );
  }

  Future<List<SpecimenPrimaryModel>?> _getData() async {
    ref
        .read(specimenStateProvider.notifier)
        .update((state) => SpecimenModelLoading());

    try {
      final repository = SpecimenRepository(ref.read(dioProvider), baseUrl: ip);
      final result = await repository.getSpcmInformation(
          specimenParams: SpecimenParams(
              hspTpCd: _getHspTpCd(),
              searchValue: textFormFieldController.text,
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

  bool _validateBeforeSearch() {
    if (searchType == 1) {
      if (textFormFieldController.text.length != 11) {
        showToast(msg: '11자리의 검체번호를 입력하세요.');
        return false;
      }
    }
    if (searchType == 0) {
      if (textFormFieldController.text.length != 8) {
        showToast(msg: '8자리의 등록번호를 입력하세요.');
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

  _renderSpecimenNoOrPatientNoSegmentHelper(segmentTextStyle) {
    return Row(
      children: [
        Expanded(
          child: MaterialSegmentedControl(
            children: {
              0: Text('등록번호', style: segmentTextStyle),
              1: Text(
                '검체번호',
                style: segmentTextStyle,
              )
            },
            horizontalPadding: const EdgeInsets.all(0),
            selectionIndex: searchType,
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
                textFormFieldController.text = '';
                print('실행됨');
                textFormFieldMaxLength = index == 0 ? 8 : 11;
                searchType = index;
              });
            },
          ),
        ),
      ],
    );
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

  _renderTitleTextHelper(title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
