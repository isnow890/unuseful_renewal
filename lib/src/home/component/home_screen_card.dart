import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class HomeScreenCard extends ConsumerWidget {
  const HomeScreenCard({Key? key, required this.contentWidget})
      : super(key: key);
  final Widget contentWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        decoration: BoxDecoration(
          color: theme.color.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: theme.deco.shadow,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: contentWidget,
      ),
    );

    //   SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   child: Card(
    //     shape: RoundedRectangleBorder(
    //       //모서리를 둥글게 하기 위해 사용
    //       borderRadius: BorderRadius.circular(16.0),
    //     ),
    //     elevation: 6.0, //그림자 깊이`
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    //       child: contentWidget,
    //     ),
    //   ),
    // );
  }
}
