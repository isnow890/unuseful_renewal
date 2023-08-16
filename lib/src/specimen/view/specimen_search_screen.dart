import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/home/model/search_history_specimen_model.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/custom_loading_indicator_widget.dart';
import 'package:unuseful/theme/component/custom_search_screen_widget.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';
import '../../../colors.dart';
import '../../common/layout/default_layout.dart';
import '../../home/provider/specimen_history_provider.dart';
import '../provider/specimenSearchValueProvider.dart';

class SpecimenSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimenSearchScreen';
  final String searchType;

  const SpecimenSearchScreen({required this.searchType, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SpecimenSearchScreenState();
}

class _SpecimenSearchScreenState extends ConsumerState<SpecimenSearchScreen> {
  final ScrollController controller = ScrollController();
  late final String searchText;
  final searchValueController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchValueController.text = ref.read(specimenSearchValueProvider);
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(specimenHistoryNotfierProvider);

    // CustomTextFormField(
// hintText: searchType == 0
// ? '8자리의 등록번호를 입력하세요.'
//     : '11자리의 검체번호를 입력하세요.',
// isSuffixDeleteButtonEnabled: true,
// controller: textFormFieldController,
// keyboardType: TextInputType.number,
// inputFormatters: [
// FilteringTextInputFormatter.digitsOnly,
// LengthLimitingTextInputFormatter(
// textFormFieldMaxLength),
// ],
// contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
// onChanged: (value) {},
// ),

    return CustomSearchScreenWidget(
      title: 'specimen',
      hintText: '등록번호 또는 검체번호를 입력하세요.',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
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

  _renderBody(search) {
    if (search is SearchHistorySpecimenMainModel) {
      return Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: search!.specimenHistory!.length + 1,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 20.0,
                );
              },
              itemBuilder: (context, index) {
                if (index == search!.specimenHistory!.length) return null;
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -3),
                  // to compact

                  onTap: () async {
                    searchValueController.text =
                        search!.specimenHistory![index]!.searchValue;
                    searchAndPop(search);
                  },
                  title: Text(
                    search!.specimenHistory![index]!.searchValue,
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () async {
                        final body = SearchHistorySpecimenModel(
                            lastUpdated: DateTime.now(),
                            searchValue:
                                search!.specimenHistory![index]!.searchValue,
                            mode: '');
                        await ref
                            .read(specimenHistoryNotfierProvider.notifier)
                            .delSpecimenHistory(body: body);
                        ref
                            .read(specimenHistoryNotfierProvider.notifier)
                            .getSpecimenHistory();
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
    } else if (search is SearchHistorySpecimenModelError) {
      return CustomErrorWidget(
          message: search.message,
          onPressed: () async => await ref
              .read(specimenHistoryNotfierProvider.notifier)
              .getSpecimenHistory());
    } else {
      return const CustomLoadingIndicatorWidget();
    }
  }

  searchAndPop(search) async {
    if (searchValueController.text.length != 8 &&
        searchValueController.text.length != 11) {
      showToast(msg: '8자리의 등록번호 또는 11자리의 검체번호를 입력해주세요.');
      return;
    }

    if (search is SearchHistorySpecimenMainModel) {

      if (searchValueController.text.trim() == '') {
        showToast(msg: '검색어를 입력하세요.');
        return;
      }

      ref
          .read(specimenSearchValueProvider.notifier)
          .update((state) => searchValueController.text);

      ref.refresh(specimenHistoryNotfierProvider);

      Navigator.pop(context);
    }
  }
}
