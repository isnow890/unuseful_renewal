import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/main_drawer.dart';
import 'package:unuseful/theme/foundation/app_theme.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class DefaultLayout extends ConsumerStatefulWidget {
  final Widget child;

  final String? title;

  final bool? tabToHideAppbar;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? centerTitle;
  final bool? isDrawerVisible;
  final List<Widget>? actions;
  final bool? canRefresh;
  final Future<void> Function()? onRefreshAndError;
  final List<ModelBase?>? state;
  final List<String>? appBarBottomList;

  const DefaultLayout({
    Key? key,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.centerTitle,
    this.actions,
    this.isDrawerVisible,
    this.onRefreshAndError,
    this.state,
    this.canRefresh,
    this.appBarBottomList,
    this.tabToHideAppbar,
  }) : super(key: key);

  @override
  ConsumerState<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends ConsumerState<DefaultLayout> {
  bool hideAppbar = false;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return SafeArea(
      child: widget.canRefresh ?? false
          ? RefreshIndicator(
              color: theme.color.primary,
              backgroundColor: theme.color.surface,
              onRefresh: widget.onRefreshAndError!,
              child: _renderScaffold(theme),
            )
          : _renderScaffold(theme),
    );
  }

  _renderScaffold(AppTheme theme) {
    //

    // AppBar appBar = _renderAppbar(theme);
    // var appBarHeight = appBar.preferredSize.height;

    print(widget.state?.any((element) => element is ModelBaseLoading));
    return Scaffold(
      drawer: widget.isDrawerVisible ?? true ? const MainDrawer() : null,
      appBar: hideAppbar ? null : _renderAppbar(theme),
      body: widget.state?.any((element) => element is ModelBaseError) ?? false
          ? CustomErrorWidget(onPressed: widget.onRefreshAndError!)
          : widget.child,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  _renderAppbar(AppTheme theme) {
    if (widget.title == null) {
      return null;
    } else {
      return AppBar(
        iconTheme: IconThemeData(color: theme.color.onPrimary),

        backgroundColor: theme.color.primary,
        centerTitle: widget.centerTitle ?? true,
        //앱바가 튀어나오도록 보이게끔
        elevation: 0,
        title: Text(
          widget.title!,
          style: theme.typo.headline5.copyWith(
            color: theme.color.onPrimary,
          ),
        ),
        actions: widget.actions,
        titleSpacing: 0,
        bottom: widget.appBarBottomList == null
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Container(
                  color: theme.color.surface,
                  child: TabBar(

                    indicatorPadding: EdgeInsets.zero,
                    tabs: List.generate(
                      widget.appBarBottomList!.length,
                      (index) => Tab(
                        text: widget.appBarBottomList![index],
                      ),
                    ),
                    // 5
                    labelColor: theme.color.primary,
                    // 6
                    unselectedLabelColor: theme.color.subtext,
                    labelStyle:
                        theme.typo.body1.copyWith(fontWeight: FontWeight.bold),

                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 2, color: theme.color.primary),
                    ),
                  ),
                ),
              ),
      );
    }
  }
}
