import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/specimen/model/specimen_model.dart';
import 'package:unuseful/src/specimen/model/specimen_params.dart';
import 'package:unuseful/src/specimen/provider/specimen_detail_params_provider.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import '../../../colors.dart';
import '../model/specimen_detail_params.dart';
import '../provider/specimen_state_provider.dart';
import '../repository/specimen_repository.dart';
import 'specimen_main_screen.dart';
import 'specimen_result_detail_screen.dart';

class SpecimenResultScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimenResult';

  final SpecimenParams params;

  const SpecimenResultScreen({
    required this.params,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SpecimenResultScreen> createState() => _SpecimenScreenState();
}

class _SpecimenScreenState extends ConsumerState<SpecimenResultScreen> {
  final searchValueController = TextEditingController();
  final ScrollController controller = ScrollController();

  // bool _isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(
      specimenStateProvider,
    );

    if (state is SpecimenModelLoading) {
      return const CircularIndicator();
    }

    final cp = state as SpecimenModel;

    return DefaultLayout(
        isDrawerVisible: false,
        title: 'text',
        child: RefreshIndicator(
          color: PRIMARY_COLOR,
          onRefresh: () async {
            final data = await _getData();
            if (data!.isEmpty) {
              showToast(msg: '데이터가 없습니다.');
              Navigator.pop(context);
            }
          },
          child: Scrollbar(
            controller: controller,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 4.0, //그림자 깊이
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                child: Column(
                                  children: [
                                    _renderSizedBox(),
                                    widget.params.searchValue!.length == 11
                                        ? SizedBox(height: 0)
                                        : _renderSection(
                                            '조회기간',
                                            '${widget.params.strDt!.substring(0, 4)}-${widget.params.strDt!.substring(4, 6)}-${widget.params.strDt!.substring(6, 8)} ~ ${widget.params.endDt!.substring(0, 4)}-${widget.params.endDt!.substring(4, 6)}-${widget.params.endDt!.substring(6, 8)}',
                                            fontSize: 16.0,
                                          ),
                                    widget.params.searchValue!.length == 11
                                        ? _renderSizedBox()
                                        : const SizedBox(),
                                    widget.params.searchValue!.length == 11
                                        ? _renderSection(
                                            '검체번호',
                                            widget.params.searchValue!,
                                            fontSize: 16.0,
                                          )
                                        : const SizedBox(),
                                    _renderSizedBox(),
                                    _renderSection(
                                      '등록번호',
                                      cp.data![0].ptNo!,
                                      fontSize: 16.0,
                                    ),
                                    _renderSizedBox(),
                                    _renderSection(
                                      '환자명',
                                      cp.data![0].ptNm!,
                                      fontSize: 16.0,
                                    ),
                                    _renderSizedBox(),
                                    _renderSection(
                                      '건수',
                                      cp.data!.length.toString(),
                                      fontSize: 16.0,
                                    ),
                                    _renderSizedBox(),
                                  ],
                                ),
                              )),
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  //모서리를 둥글게 하기 위해 사용
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 4.0, //그림자 깊이
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 15),
                                          Text(
                                            cp.data![index - 1].ordDt ?? '',
                                            style: TextStyle(
                                              color: PRIMARY_COLOR,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Divider(
                                        height: 5,
                                      ),
                                      ExpansionPanelList(
                                        expandedHeaderPadding:
                                            EdgeInsets.all(0),
                                        animationDuration:
                                            Duration(milliseconds: 500),
                                        elevation: 0,
                                        children: cp.data![index - 1].exmType!
                                            .map<ExpansionPanel>((e) {
                                          return ExpansionPanel(
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return ListTile(
                                                  title: Text(
                                                    '${e.exrmExmCtgCd ?? ''} ${e.exmCtgAbbrNm ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              },
                                              body: Column(
                                                children: [
                                                  ...e.general!
                                                      .map((general) =>
                                                          Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          10),
                                                              child: Container(
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .all(
                                                                    const Radius
                                                                            .circular(
                                                                        10.0),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(15),
                                                                  child: Column(
                                                                    children: [
                                                                      _renderSection(
                                                                        '병원',
                                                                        general
                                                                            .hspTpNm,
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '검체번호',
                                                                        general
                                                                            .spcmNo,
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '접수번호',
                                                                        general.exmAcptNo ==
                                                                                '0'
                                                                            ? ''
                                                                            : general.exmAcptNo,
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '검사상태',
                                                                        general
                                                                            .exmPrgrStsNm,
                                                                        hspTpCd:
                                                                            general.hspTpCd,
                                                                        exrmExmCtgCd:
                                                                            general.exrmExmCtgCd,
                                                                        spcmNo:
                                                                            general.spcmNo,
                                                                        buttonVisible:
                                                                            _checkButtonVisibility(general.exmPrgrStsCd),
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '채혈일시',
                                                                        general.blclDtm ==
                                                                                null
                                                                            ? ''
                                                                            : DateFormat('yyyy-MM-dd HH:mm').format(general.blclDtm!),
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '채혈자',
                                                                        general
                                                                            .blclStfNo,
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '접수일시',
                                                                        general.acptDtm ==
                                                                                null
                                                                            ? ''
                                                                            : DateFormat('yyyy-MM-dd HH:mm').format(general.acptDtm!),
                                                                      ),
                                                                      _renderSizedBox(),
                                                                      _renderSection(
                                                                        '결과보고일시',
                                                                        general.brfgDtm ==
                                                                                null
                                                                            ? ''
                                                                            : DateFormat('yyyy-MM-dd HH:mm').format(general.brfgDtm!),
                                                                      ),
                                                                      _renderSizedBox(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )))
                                                      .toList(),
                                                ],
                                              ),
                                              isExpanded: e.isExpanded,
                                              canTapOnHeader: true);
                                        }).toList(),
                                        expansionCallback:
                                            (int index2, bool isExpanded) {
                                          setState(
                                            () {
                                              cp
                                                  .data![index - 1]
                                                  .exmType![index2]
                                                  .isExpanded = !isExpanded;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 5,
                      );
                    },
                    itemCount: state.data!.length + 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        context.goNamed(SpecimenMainScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text('이전'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _checkButtonVisibility(value) {
    if (value == 'X' || value == 'B') return false;
    return true;
  }

  _barcodeScan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    print(barcodeScanRes);
    // barcodeText = barcodeScanRes;
  }

  _renderSizedBox() {
    return SizedBox(
      height: 7,
    );
  }

  _renderSection(title, name,
      {String? hspTpCd,
      String? spcmNo,
      String? exrmExmCtgCd,
      fontSize = 13.0,
      buttonVisible = false}) {
    return Row(children: [
      SizedBox(
        width: 100,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Row(
        children: [
          Text(name, style: TextStyle(fontSize: 13)),
          !buttonVisible
              ? SizedBox()
              : SizedBox(
                  height: 25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(specimenDetailParamsProvider.notifier)
                            .update((state) => SpecimenDetailParams(
                                  hspTpCd: hspTpCd!,
                                  spcmNo: spcmNo!,
                                  exrmExmCtgCd: exrmExmCtgCd!,
                                ));

                        context.pushNamed(SpecimenResultDetailScreen.routeName,
                            extra: widget.params);
                      },
                      child: Text(
                        '검사내역',
                        style: TextStyle(fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: PRIMARY_COLOR,
                        side: BorderSide(color: PRIMARY_COLOR, width: 1),
                      ),
                    ),
                  ),
                )
        ],
      ),
    ]);
  }

  Future<List<SpecimenPrimaryModel>?> _getData() async {
    ref
        .read(specimenStateProvider.notifier)
        .update((state) => SpecimenModelLoading());

    try {
      final repository = SpecimenRepository(ref.read(dioProvider), baseUrl: ip);
      final result =
          await repository.getSpcmInformation(specimenParams: widget.params);

      ref
          .read(specimenStateProvider.notifier)
          .update((state) => SpecimenModel(data: result));
      return result;
    } catch (e) {
      ref
          .read(specimenStateProvider.notifier)
          .update((state) => SpecimenModelError(message: '에러가 발생하였습니다.'));
    }
  }
}
