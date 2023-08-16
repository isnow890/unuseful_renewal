import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/src/home/component/home_screen_card.dart';
import 'package:unuseful/src/home/component/logout_dialog.dart';
import 'package:unuseful/src/home/component/section_title.dart';
import 'package:unuseful/src/home/model/search_history_specimen_model.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';
import 'package:unuseful/src/home/provider/specimen_history_provider.dart';
import 'package:unuseful/src/home/component/hit_schedule_section.dart';
import 'package:unuseful/src/home/component/meal_section.dart';
import 'package:unuseful/src/specimen/provider/specimenSearchValueProvider.dart';
import 'package:unuseful/src/specimen/view/specimen_main_screen.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/text_title.dart';
import '../../../theme/model/menu_model.dart';
import '../../telephone/provider/telephone_search_value_provider.dart';
import '../../../router/provider/auth_provider.dart';
import '../../common/layout/default_layout.dart';
import '../component/specimen_section.dart';
import '../component/telephone_section.dart';
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
      title: TextTitle(title: menus[0].menuName),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 15,
              ),
              SectionTitle(section: menus[5].menuName),
              const Divider(
                height: 15,
              ),
              const HitScheduleSection(),
              const SizedBox(
                height: 15,
              ),
              SectionTitle(section: menus[2].menuName),
              const Divider(
                height: 15,
              ),
              const MealSection(),
              SectionTitle(section: menus[1].menuName),
              const TelephoneSection(),
              SizedBox(
                height: 20,
              ),
              SectionTitle(section: menus[3].menuName),
              const SpecimenSection(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
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
