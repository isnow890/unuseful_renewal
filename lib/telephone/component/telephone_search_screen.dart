import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/custom_loading_indicator_widget.dart';
import 'package:unuseful/common/model/search_history_telephone_model.dart';

import '../../common/component/custom_error_widget.dart';
import '../../common/component/custom_text_form_field.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../../common/provider/telehphone_history_provider.dart';
import '../provider/telephone_search_value_provider.dart';

class TelephoneSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'telephoneSearchScreen';

  const TelephoneSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TelephoneSearchScreen> createState() =>
      _TelephoneSearchScreenState();
}

class _TelephoneSearchScreenState extends ConsumerState<TelephoneSearchScreen> {
  final ScrollController controller = ScrollController();
  late final String searchText;
  Timer? _timer;
  final searchValueController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(telephoneHistoryNotfierProvider);
    final searchValue = ref.watch(telephoneSearchValueProvider);

    return DefaultLayout(
      isDrawerVisible: false,
      title: Text('telephone'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    autofocus: true,
                    controller: searchValueController,
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
                    hintText: 'Enter some text to search.',
                    onChanged: (value) {
                      if (_timer?.isActive ?? false) _timer!.cancel();
                      _timer = Timer(
                        const Duration(milliseconds: 500),
                        () {
                          ref
                              .read(telephoneSearchValueProvider.notifier)
                              .update((state) => value);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 5,),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 35,
                      color: PRIMARY_COLOR,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints()),
              ],
            ),
            Expanded(
              child: SizedBox(height: 100, child: renderBody(search)),
            )
          ],
        ),
      ),
    );
  }

  renderBody(search) {
    print('로딩중');

    if (search is SearchHistoryTelephoneMainModel) {
      print('데이터 나와야함');

      return ListView.separated(
        itemCount: search!.telephoneHistory!.length,
        separatorBuilder: (context, index) {
          return Divider(
            height: 20.0,
          );
        },
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              searchValueController.text =
                  search!.telephoneHistory![index]!.searchValue;
            },
            title: Text(
              search!.telephoneHistory![index]!.searchValue,
            ),
            trailing: Icon(Icons.delete),
          );
        },
      );
    } else if (search is SearchHistoryTelephoneModelError) {
      return CustomErrorWidget(
          message: search.message,
          onPressed: () async => ref
              .read(telephoneHistoryNotfierProvider.notifier)
              .getTelephoneHistory());
    } else {
      print('로딩중');
      return CustomLoadingIndicatorWidget();
    }
  }
}
