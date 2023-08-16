import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/home/component/home_screen_card.dart';
import 'package:unuseful/src/home/model/search_history_specimen_model.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';
import 'package:unuseful/src/home/provider/specimen_history_provider.dart';
import 'package:unuseful/src/home/widget/hit_schedule_section.dart';
import 'package:unuseful/src/home/widget/logout_dialog.dart';
import 'package:unuseful/src/home/widget/meal_section.dart';
import 'package:unuseful/src/specimen/provider/specimenSearchValueProvider.dart';
import 'package:unuseful/src/specimen/view/specimen_main_screen.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/text_title.dart';
import '../../telephone/provider/telephone_search_value_provider.dart';
import '../../../router/provider/auth_provider.dart';
import '../../common/layout/default_layout.dart';
import '../provider/telehphone_history_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final loginValue = ref.read(loginVariableStateProvider);

    int _current = 0;

    // final login = ref.watch(loginVariableStateProvider);
    //
    // ref.watch(hspTpCdProvider.notifier).update((state) => login.hspTpCd!);

    // IconButton(
    // ,
    // icon: Icon(Icons.logout)),

    return DefaultLayout(
      actions: [
        Button(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => LogoutDialog(
                onLogoutPressed: ref.read(authProvider.notifier).logout,
              ),
            );
          },
          type: ButtonType.flat,
          text: '로그아웃',
        )
      ],
      title: TextTitle(title: '홈'),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _renderSection(section: 'schedule'),
                HitScheduleSection(),
                SizedBox(
                  height: 8,
                ),
                _renderSection(section: 'meal'),
                MealSection(),
//glkwjgklwejglkwejgjklwe
                SizedBox(
                  height: 20,
                ),
                _renderSection(section: 'telephone'),
                TelephoneSection(),
                SizedBox(
                  height: 20,
                ),
                _renderSection(section: 'specimen'),
                SpecimenSection(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpecimenSection extends ConsumerWidget {
  const SpecimenSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specimen = ref.watch(specimenHistoryNotfierProvider);

    return HomeScreenCard(
      contentWidget: Column(
        children: [
          _renderBody(specimen, ref, context),
        ],
      ),
    );
  }

  _renderBody(specimen, WidgetRef ref, BuildContext context) {
    if (specimen is SearchHistorySpecimenModelLoading) {
      return const CustomCircularProgressIndicator();
    } else if (specimen is SearchHistorySpecimenModelError) {
      return CustomErrorWidget(
          message: specimen.message,
          onPressed: () {
            ref
                .read(specimenHistoryNotfierProvider.notifier)
                .getSpecimenHistory();
          });
    } else if (specimen is SearchHistorySpecimenMainModel) {
      return specimen.specimenHistory!.length == 0
          ? Row(
              children: [
                Text(
                  '최근 조회 내역이 없습니다.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '최근 조회 내역',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: specimen.specimenHistory!
                      .take(5)
                      .map((e) => _renderChip(
                          SearchHistoryTelephoneModel(
                              searchValue: e.searchValue,
                              mode: '',
                              lastUpdated: DateTime.now()),
                          ref,
                          context))
                      .toList(),
                )
              ],
            );
    }
  }

  Widget _renderChip(
      SearchHistoryTelephoneModel body, WidgetRef ref, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Chip(
        label: GestureDetector(
          child: Text(body.searchValue),
          onTap: () {
            ref
                .read(specimenSearchValueProvider.notifier)
                .update((state) => body.searchValue);

            context.goNamed(
              SpecimenMainScreen.routeName,
            );
          },
        ),
        backgroundColor: Colors.white,
        deleteIcon: Icon(
          Icons.close,
          color: PRIMARY_COLOR,
        ),
        onDeleted: () async {
          await ref
              .read(telephoneHistoryNotfierProvider.notifier)
              .delTelephoneHistory(body: body);

          await ref
              .read(telephoneHistoryNotfierProvider.notifier)
              .getTelephoneHistory();
        },
      ),
    );
  }
}

class TelephoneSection extends ConsumerWidget {
  const TelephoneSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telephone = ref.watch(telephoneHistoryNotfierProvider);

    return HomeScreenCard(
      contentWidget: Column(
        children: [
          _renderBody(telephone, ref, context),
        ],
      ),
    );
  }

  _renderBody(telephone, WidgetRef ref, BuildContext context) {
    if (telephone is SearchHistoryTelephoneModelLoading) {
      return const CustomCircularProgressIndicator();
    } else if (telephone is SearchHistoryTelephoneModelError) {
      return CustomErrorWidget(
          message: telephone.message,
          onPressed: () {
            ref
                .read(telephoneHistoryNotfierProvider.notifier)
                .getTelephoneHistory();
          });
    } else if (telephone is SearchHistoryTelephoneMainModel) {
      return telephone.telephoneHistory!.length == 0
          ? Row(
              children: [
                Text(
                  '최근 조회 내역이 없습니다.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '최근 조회 내역',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: telephone.telephoneHistory!
                      .take(5)
                      .map((e) => _renderChip(
                          SearchHistoryTelephoneModel(
                              searchValue: e.searchValue,
                              mode: '',
                              lastUpdated: DateTime.now()),
                          ref,
                          context))
                      .toList(),
                )
              ],
            );
    }
  }

  Widget _renderChip(
      SearchHistoryTelephoneModel body, WidgetRef ref, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Chip(
        label: GestureDetector(
          child: Text(body.searchValue),
          onTap: () {
            ref
                .read(telephoneSearchValueProvider.notifier)
                .update((state) => body.searchValue);

            context.goNamed(
              TelePhoneMainScreen.routeName,
            );
          },
        ),
        backgroundColor: Colors.white,
        deleteIcon: Icon(
          Icons.close,
          color: PRIMARY_COLOR,
        ),
        onDeleted: () async {
          await ref
              .read(telephoneHistoryNotfierProvider.notifier)
              .delTelephoneHistory(body: body);

          await ref
              .read(telephoneHistoryNotfierProvider.notifier)
              .getTelephoneHistory();
        },
      ),
    );
  }
}

//
//
//   Widget _sliderIndicator() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: imageList.asMap().entries.map((entry) {
//           return GestureDetector(
//             onTap: () => _controller.animateToPage(entry.key),
//             child: Container(
//               width: 12,
//               height: 12,
//               margin:
//               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color:
//                 Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
