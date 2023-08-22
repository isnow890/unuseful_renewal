import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/specimen/model/specimen_params.dart';

import '../../../colors.dart';
import '../model/specimen_detail_params.dart';
import '../provider/specimen_detail_params_provider.dart';
import '../view/specimen_result_detail_screen.dart';

class SpecimenKeyValueSection extends ConsumerWidget {
  const SpecimenKeyValueSection( {
    Key? key,
    required this.sectionTitle,
    required this.sectionValue,
    this.hspTpCd,
    this.spcmNo,
    this.exrmExmCtgCd,
    this.fontSize = 13.0,
    this.buttonVisible = false,
    this.params,
  }) : super(key: key);

  final String sectionTitle;
  final String sectionValue;
  final String? hspTpCd;
  final String? spcmNo;
  final String? exrmExmCtgCd;
  final double fontSize;

  final bool buttonVisible;

  final SpecimenParams? params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(children: [
      SizedBox(
        width: 100,
        child: Text(
          sectionTitle,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Row(
        children: [
          Text(sectionValue, style: const TextStyle(fontSize: 13)),
          !buttonVisible
              ? const SizedBox()
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
                            extra: params);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: PRIMARY_COLOR,
                        side: const BorderSide(color: PRIMARY_COLOR, width: 1),
                      ),
                      child: const Text(
                        '검사내역',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                )
        ],
      ),
    ]);
  }
}
