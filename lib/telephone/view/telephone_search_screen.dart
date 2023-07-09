import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/custom_loading_indicator_widget.dart';
import 'package:unuseful/common/component/general_toast_message.dart';
import 'package:unuseful/common/model/search_history_telephone_model.dart';

import '../../common/component/custom_error_widget.dart';
import '../../common/component/custom_search_screen_widget.dart';
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
    searchValueController.text = ref.read(telephoneSearchValueProvider);
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(telephoneHistoryNotfierProvider);

    return CustomSearchScreenWidget(
      title: 'telephone',
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
    if (search is SearchHistoryTelephoneMainModel) {
      return Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: search!.telephoneHistory!.length + 1,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 20.0,
                );
              },
              itemBuilder: (context, index) {
                if (index == search!.telephoneHistory!.length) return null;
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -3),
                  // to compact

                  onTap: () async {
                    searchValueController.text =
                        search!.telephoneHistory![index]!.searchValue;
                    searchAndPop(search);
                  },
                  title: Text(
                    search!.telephoneHistory![index]!.searchValue,
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () async {
                        final body = SearchHistoryTelephoneModel(
                            lastUpdated: DateTime.now(),
                            searchValue:
                                search!.telephoneHistory![index]!.searchValue,
                            mode: '');
                        await ref
                            .read(telephoneHistoryNotfierProvider.notifier)
                            .delTelephoneHistory(body: body);
                        ref
                            .read(telephoneHistoryNotfierProvider.notifier)
                            .getTelephoneHistory();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: PRIMARY_COLOR,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints()),
                );
              },
            ),
          ),
        ],
      );
    } else if (search is SearchHistoryTelephoneModelError) {
      return CustomErrorWidget(
          message: search.message,
          onPressed: () async => await ref
              .read(telephoneHistoryNotfierProvider.notifier)
              .getTelephoneHistory());
    } else {
      return const CustomLoadingIndicatorWidget();
    }
  }

  searchAndPop(search) async {
    final body = SearchHistoryTelephoneModel(
        lastUpdated: DateTime.now(),
        searchValue: searchValueController.text,
        mode: '');

    if (search is SearchHistoryTelephoneMainModel) {
      print('타나');
      if (searchValueController.text.trim() == '') {
        showToast(msg: '검색어를 입력하세요.');
        return;
      }
      await ref
          .read(telephoneHistoryNotfierProvider.notifier)
          .saveTelephoneHistory(body: body);
      ref
          .read(telephoneSearchValueProvider.notifier)
          .update((state) => searchValueController.text);
      ref.read(telephoneHistoryNotfierProvider.notifier).getTelephoneHistory();
      // ref.refresh(telephoneHistoryNotfierProvider);

      Navigator.pop(context);
    }
  }
}
