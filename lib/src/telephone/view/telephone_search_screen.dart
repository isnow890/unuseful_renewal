import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/custom_search_screen_widget.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../colors.dart';
import '../../../theme/model/menu_model.dart';
import '../../home/provider/telehphone_history_provider.dart';
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
    searchValueController.text = ref.read(telephoneSearchValueProvider);
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(telephoneHistoryNotfierProvider);

    return CustomSearchScreenWidget(
      title: MenuModel.getMenuInfo(TelePhoneMainScreen.routeName).menuName,
      onFieldSubmitted: (value) {
        searchAndPop(search);
      },
      body: _renderBody(search),
      onPressed: () async {
        searchAndPop(search);
      },
      searchValueController: searchValueController,
    );
  }

  Widget _renderBody(search) {

    final theme = ref.watch(themeServiceProvider);

    if (search is ModelBaseLoading) {
      return const CircularIndicator();
    } else {
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: search.history!.length + 1,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 20.0,
                );
              },
              itemBuilder: (context, index) {
                if (index == search.history!.length) return null;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 2.0),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -3),
                  // to compact

                  onTap: () async {
                    searchValueController.text =
                        search!.history![index].searchValue;
                    searchAndPop(search);
                  },
                  title: Text(
                    search!.history![index]!.searchValue,
                    style: theme.typo.body1,
                  ),
                  trailing: Button(
                    icon: 'close',
                    type: ButtonType.flat,
                    size: ButtonSize.small,
                    onPressed: () async {
                      final body = SearchHistoryModel(
                          lastUpdated: DateTime.now(),
                          searchValue: search!.history![index]!.searchValue,
                          mode: '');
                      await ref
                          .read(telephoneHistoryNotfierProvider.notifier)
                          .delTelephoneHistory(body: body);
                      ref
                          .read(telephoneHistoryNotfierProvider.notifier)
                          .getTelephoneHistory();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  searchAndPop(search) async {
    final body = SearchHistoryModel(
        lastUpdated: DateTime.now(),
        searchValue: searchValueController.text,
        mode: '');

    if (search is SearchHistoryMainModel) {
      // if (searchValueController.text.trim() == '') {
      //   showToast(msg: '검색어를 입력하세요.');
      //   return;
      // }

      if (searchValueController.text.trim() != '') {
        await ref
            .read(telephoneHistoryNotfierProvider.notifier)
            .saveTelephoneHistory(body: body);
      }

      ref
          .read(telephoneSearchValueProvider.notifier)
          .update((state) => searchValueController.text);
      ref.read(telephoneHistoryNotfierProvider.notifier).getTelephoneHistory();
      // ref.refresh(telephoneHistoryNotfierProvider);

      Navigator.pop(context);
    }
  }
}
