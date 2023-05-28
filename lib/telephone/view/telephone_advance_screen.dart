import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';

import '../../common/const/colors.dart';
import '../model/telephone_model.dart';
import '../provider/telephone_advance_provider.dart';
import '../provider/telephone_search_value_provider.dart';

class TelephoneAdvanceScreen extends ConsumerWidget {
  const TelephoneAdvanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchValue = ref.watch(telephoneSearchValueProvider);
    print('빌드함?');
    final state = ref.watch(telephoneAdvanceFamilyProvider(searchValue));

    if (state is TelephoneModel<TelephoneAdvanceModel>) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(telephoneAdvanceNotifierProvider.notifier);
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.data[index].KOR_NM,
                        style: TextStyle(
                            fontSize: 22,
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone_android_outlined,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  title: Text('${state.data[index].DEPT_NM}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.data[index].HSP_TP_CD}'),
                      Row(
                        children: [
                          Text(
                            state.data[index].ETNT_TEL_NO,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PRIMARY_COLOR),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.data[index].UGT_TEL_NO,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  isThreeLine: true,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 20.0,
                );
              },
              itemCount: state.data.length),
        ),
      );
    }

    if (state is TelephoneModelLoading) {
      return CircularProgressIndicator();
    } else
      return Center(
        child: Text('에러'),
      );
  }
}
