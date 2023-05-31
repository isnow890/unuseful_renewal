import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/common/model/cursor_pagination_model.dart';
import 'package:unuseful/telephone/model/telephone_basic_model.dart';
import 'package:unuseful/telephone/provider/telephone_basic_provider.dart';
import 'package:unuseful/telephone/provider/telephone_search_value_provider.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/utils/pagination_utils.dart';

class TelephoneBasicScreen extends ConsumerStatefulWidget {
  const TelephoneBasicScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TelephoneBasicScreen> createState() =>
      _TelephoneBasicScreenState();
}

class _TelephoneBasicScreenState extends ConsumerState<TelephoneBasicScreen> {
  // String? searchValue;
  final ScrollController controller = ScrollController();





@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
}
  void listener() {
    PaginationUtils.paginate(
        controller: controller, provider: ref.read(telephoneBasicNotifierProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {

    final searchValue = ref.watch(telephoneSearchValueProvider);
    print('빌드함?');
    final state = ref.watch(telephoneBasicNotifierProvider);

    if (state is CursorPagination<TelephoneBasicModel>){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async{
            ref.read(telephoneBasicNotifierProvider.notifier);
          },
          child: ListView.separated(

              itemBuilder: (context, index) {
                return ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.data[index].hspTpCd,
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
                        color: Colors.red,
                      ),
                    ],
                  ),
                  title: Text(state.data[index].deptNm),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( state.data[index].telNoAbbrNm),
                      Row(
                        children: [
                          Text(
                            state.data[index].etntTelNo,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PRIMARY_COLOR),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.data
                            [index].telNoNm,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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


    if (state is CursorPaginationLoading){
      return CircularProgressIndicator();
    }

    else
      return Center(child: Text('에러'),);
  }
}
