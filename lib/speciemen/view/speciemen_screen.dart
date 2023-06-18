import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/speciemen/model/speciemen_params.dart';
import 'package:unuseful/speciemen/model/specimen_model.dart';
import 'package:unuseful/speciemen/provider/specimen_provider.dart';

import '../../common/component/custom_error_widget.dart';
import '../../common/component/custom_loading_indicator_widget.dart';
import '../../common/component/custom_radio_tile.dart';
import '../../common/component/custom_text_form_field.dart';
import '../../common/component/main_drawer.dart';
import '../../common/const/colors.dart';
import '../../common/provider/drawer_selector_provider.dart';
import '../../telephone/provider/telephone_order_radio_tile_provider.dart';
import '../../telephone/provider/telephone_search_value_provider.dart';

class SpeciemenScreen extends ConsumerStatefulWidget {

  const SpeciemenScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SpeciemenScreen> createState() => _SpeciemenScreenState();
}

class _SpeciemenScreenState extends ConsumerState<SpeciemenScreen> {
  final searchValueController = TextEditingController();

  final String searchValue = '';

  bool _isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final haha = List<String>.generate(1, (index) => 'test');

    final state = ref.watch(specimenFamilyProvider(SpeciemenParams()));

    if (state is SpecimenModelLoading) {
      return _renderDefaultLayout(widget: const CustomLoadingIndicatorWidget());
    }

    if (state is SpecimenModelInit) {
      return _renderDefaultLayout(
        widget: Row(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2023-06-16 (토)',
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                        ),
                        ExpansionPanelList(
                          expandedHeaderPadding: EdgeInsets.all(0),
                          animationDuration: Duration(milliseconds: 500),
                          elevation: 0,
                          children: haha.map<ExpansionPanel>((String ramen) {
                            return ExpansionPanel(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(
                                      'L80 응급검사기타',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                                body: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: new BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            _renderSection('병원', '이대서울병원'),
                                            _renderSizedBox(),
                                            _renderSection(
                                                '검체번호', '03272334461'),
                                            _renderSizedBox(),
                                            _renderSection('접수번호', '1'),
                                            _renderSizedBox(),
                                            _renderSection('검사상태', '채혈',
                                                buttonVisible: true),
                                            _renderSizedBox(),
                                            _renderSection(
                                                '채혈일시', '2023-03-27 14:08'),
                                            _renderSizedBox(),
                                            _renderSection('채혈자', '30430'),
                                            _renderSizedBox(),
                                            _renderSection(
                                                '접수일시', '2023-03-27 14:08'),
                                            _renderSizedBox(),
                                            _renderSection(
                                                '결과보고일시', '2023-03-27 14:08'),
                                            _renderSizedBox(),
                                          ],
                                        ),
                                      ),
                                    )),
                                isExpanded: _isExpanded,
                                canTapOnHeader: true);
                          }).toList(),
                          expansionCallback: (int index, bool isExpanded) {
                            print('열려라');
                            _isExpanded = !isExpanded;

                            setState(() {
                              print(isExpanded);
                              print(!isExpanded);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (state is SpecimenModelError) {
      return _renderDefaultLayout(
          widget: CustomErrorWidget(
              message: state.message,
              onPressed: () {
                ref.read(specimenFamilyProvider(SpeciemenParams(
                    searchValue: searchValue,
                    strDt: null,
                    endDt: null,
                    orderBy: 'desc')));
              }));
    }

    return _renderDefaultLayout(
      widget: Center(
        child: Text('speciemen'),
      ),
    );
  }

  barcodeScan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    print(barcodeScanRes);
    // barcodeText = barcodeScanRes;
  }

  _renderDefaultLayout({required Widget widget}) {
    return DefaultLayout(
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.barcode_reader,
          size: 30,
        ),
      ),
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 30,
          child: CustomTextFormField(
            contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
            hintText: 'Scanned data will be shown. Or just type it.',
            onChanged: (value) {
              ref
                  .read(telephoneSearchValueProvider.notifier)
                  .update((state) => value);
            },
          ),
        ),
      ),
      child: widget,
    );
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
