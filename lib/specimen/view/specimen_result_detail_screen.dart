import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/specimen/model/specimen_detail_model.dart';
import 'package:unuseful/specimen/model/specimen_params.dart';
import 'package:unuseful/specimen/provider/specimen_provider.dart';
import 'package:unuseful/specimen/view/specimen_main_screen.dart';

import '../../common/component/custom_error_widget.dart';
import '../../common/component/custom_loading_indicator_widget.dart';
import '../../common/layout/default_layout.dart';

class SpecimenResultDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimenResultDetail';

  const SpecimenResultDetailScreen({
    required this.params,
    Key? key,
  }) : super(key: key);

  final SpecimenParams params;

  @override
  ConsumerState<SpecimenResultDetailScreen> createState() =>
      _SpecimenResultDetailScreenState();
}

class _SpecimenResultDetailScreenState
    extends ConsumerState<SpecimenResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(specimenNotifierProvider);

    if (state is SpecimenDetailModelLoading)
      return DefaultLayout(
        backgroundColor: Colors.grey[200],
        title: Text('detailed'),
        child: CustomLoadingIndicatorWidget(),
      );

    if (state is SpecimenDetailModelError) {
      return DefaultLayout(
          backgroundColor: Colors.grey[200],
          title: Text('detailed'),
          child: CustomErrorWidget(
              message: state.message,
              onPressed: () async => ref
                  .read(specimenNotifierProvider.notifier)
                  .getSpcmDetailInformation()));
    }

    final cp = state as SpecimenDetailModel;

    print(cp.data!.length);

    return DefaultLayout(
        backgroundColor: Colors.grey[200],
        title: Text('${cp.data![0].exmCtgCd} ${cp.data![0].exmCtgAbbrNm} '),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 1),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4.0, //그림자 깊이
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 15,
                            ),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cp.data![index].eitmAbbr,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: PRIMARY_COLOR,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '단위 : ${cp.data![index].exrsUnit}',
                                          style: TextStyle(
                                            color: BODY_TEXT_COLOR,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _renderSection(
                                        '검사코드', cp.data![index].exmCd),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _renderSection(
                                        '결과', cp.data![index].exrsCnte),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _renderSection(
                                        '정상범위', cp.data![index].srefval),
                                  ],
                                )),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 10,
                      );
                    },
                    itemCount: cp.data!.length),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text('이전'),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.goNamed(SpecimenMainScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text('다른 날짜 조회'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _renderSection(
    title,
    value, {
    titleFontSize = 13.0,
    valueFontSize = 13.0,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w500,
              color: BODY_TEXT_COLOR,
            ),
          ),
        ),
        Row(
          children: [
            Text(value, style: TextStyle(fontSize: valueFontSize)),
          ],
        ),
      ],
    );
  }
}
