import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class BaseSearchScreenWidget extends ConsumerStatefulWidget {
  const BaseSearchScreenWidget({
    required this.itemBuilder,
    required this.itemCount,
    this.controller,
    required this.header,
    super.key,
  });

  final Widget header;
  final ScrollController? controller;
  final int itemCount;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  @override
  ConsumerState<BaseSearchScreenWidget> createState() =>
      _BaseSearchScreenWidgetState();
}

class _BaseSearchScreenWidgetState
    extends ConsumerState<BaseSearchScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: theme.color.hintContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )),
            height: 50,
            child: widget.header),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: widget.controller,
            separatorBuilder: (context, index) {
              return const Divider(
                height: 20.0,
              );
            },
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
          ),
        ),
      ],
    );
  }
}
