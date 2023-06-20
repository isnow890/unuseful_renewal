import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/custom_loading_indicator_widget.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/specimen/model/specimen_model.dart';
import 'package:unuseful/specimen/provider/specimen_provider.dart';

import '../../common/const/colors.dart';

class SpecimenResultScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimenResult';

  const SpecimenResultScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SpecimenResultScreen> createState() => _SpecimenScreenState();
}

class _SpecimenScreenState extends ConsumerState<SpecimenResultScreen> {
  final searchValueController = TextEditingController();

  // bool _isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, bool> expansionExpandedindexList = {};

    final state = ref.watch(
      specimenStateProvider,
    );

    if (state is SpecimenModelLoading)
      return DefaultLayout(
        backgroundColor: Colors.grey[200],
        title: Text('text'),
        child: CustomLoadingIndicatorWidget(),
      );

    final cp = state as SpecimenModel;



    return DefaultLayout(
        backgroundColor: Colors.grey[200],
        title: Text('text'),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 15),
                                  Text(cp.data![index].ordDt ?? '',
                                      style: TextStyle(
                                        color: PRIMARY_COLOR,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 10,
                              ),
                              ExpansionPanelList(
                                expandedHeaderPadding: EdgeInsets.all(0),
                                animationDuration: Duration(milliseconds: 500),
                                elevation: 0,
                                children: cp.data![index].exmType!
                                    .map<ExpansionPanel>((e) {
                                  return ExpansionPanel(
                                      headerBuilder: (BuildContext context,
                                          bool isExpanded) {
                                        return ListTile(
                                          title: Text(
                                            '${e.exrmExmCtgCd ?? ''} ${e.exmCtgAbbrNm ?? ''}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      },
                                      body: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          child: Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  new BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  _renderSection(
                                                      '병원', '이대서울병원'),
                                                  _renderSizedBox(),
                                                  _renderSection(
                                                      '검체번호', '03272334461'),
                                                  _renderSizedBox(),
                                                  _renderSection('접수번호', '1'),
                                                  _renderSizedBox(),
                                                  _renderSection('검사상태', '채혈',
                                                      buttonVisible: true),
                                                  _renderSizedBox(),
                                                  _renderSection('채혈일시',
                                                      '2023-03-27 14:08'),
                                                  _renderSizedBox(),
                                                  _renderSection(
                                                      '채혈자', '30430'),
                                                  _renderSizedBox(),
                                                  _renderSection('접수일시',
                                                      '2023-03-27 14:08'),
                                                  _renderSizedBox(),
                                                  _renderSection('결과보고일시',
                                                      '2023-03-27 14:08'),
                                                  _renderSizedBox(),
                                                ],
                                              ),
                                            ),
                                          )),
                                      isExpanded: e.isExpanded,
                                      canTapOnHeader: true);
                                }).toList(),
                                expansionCallback:
                                    (int index2, bool isExpanded) {


                                  setState(() {
                                    cp.data![index].exmType![index2].isExpanded = !isExpanded;
                                    print (expansionExpandedindexList[index]);
                                  }
                                  ,);
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
                height: 20,
              );
            },
            itemCount: state.data!.length));
  }

  barcodeScan() async {
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

  _renderSection(title, name, {buttonVisible = false}) {
    return Row(children: [
      SizedBox(
        width: 100,
        child: Text(
          title,
          style: TextStyle(
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
                        onPressed: () {},
                        child: Text(
                          '검사내역',
                          style: TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: PRIMARY_COLOR,
                          side: BorderSide(color: PRIMARY_COLOR, width: 1),
                        )),
                  ),
                )
        ],
      ),
    ]);
  }
}
