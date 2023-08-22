import 'package:flutter/material.dart';
import 'package:unuseful/src/specimen/component/specimen_key_value_section.dart';
import 'package:unuseful/src/specimen/model/specimen_params.dart';

class SpecimenResultHeaderInfo extends StatelessWidget {
  const SpecimenResultHeaderInfo(
      {Key? key,
      required this.params,
      required this.ptNo,
      required this.ptNm,
      required this.count})
      : super(key: key);

  final SpecimenParams params;
  final String ptNo;
  final String ptNm;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0, //그림자 깊이
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                _renderSizedBox(),
                params.searchValue!.length == 11
                    ? const SizedBox()
                    : SpecimenKeyValueSection(
                        sectionTitle: '조회기간',
                        sectionValue:
                            '${params.strDt!.substring(0, 4)}-${params.strDt!.substring(4, 6)}-${params.strDt!.substring(6, 8)} ~ ${params.endDt!.substring(0, 4)}-${params.endDt!.substring(4, 6)}-${params.endDt!.substring(6, 8)}',
                        fontSize: 16.0,
                        params: params,
                      ),
                params.searchValue!.length == 11
                    ? _renderSizedBox()
                    : const SizedBox(),
                params.searchValue!.length == 11
                    ? SpecimenKeyValueSection(
                        fontSize: 16.0,
                        sectionTitle: '검체번호',
                        sectionValue: params.searchValue!,
                      )
                    : const SizedBox(),
                _renderSizedBox(),
                SpecimenKeyValueSection(
                  fontSize: 16.0,
                  sectionTitle: '등록번호',
                  sectionValue: ptNo,
                ),
                _renderSizedBox(),
                SpecimenKeyValueSection(
                  fontSize: 16.0,
                  sectionTitle: '환자명',
                  sectionValue: ptNm,
                ),
                _renderSizedBox(),
                SpecimenKeyValueSection(
                  fontSize: 16.0,
                  sectionTitle: '건수',
                  sectionValue: count,
                ),
                _renderSizedBox(),
              ],
            ),
          )),
    );
  }

  _renderSizedBox() {
    return SizedBox(
      height: 7,
    );
  }
}
