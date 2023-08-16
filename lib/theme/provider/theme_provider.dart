import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/dark_theme.dart';
import 'package:unuseful/theme/foundation/app_theme.dart';
import 'package:unuseful/theme/light_theme.dart';

final themeServiceProvider =
NotifierProvider<ThemeService, AppTheme>(() => ThemeService());

class ThemeService extends Notifier<AppTheme> {
  @override
  AppTheme build() {
    // TODO: implement build
    return LightTheme();
  }

  void toggleTheme() {
    state = state.brightness == Brightness.light ? DarkTheme() : LightTheme();
  }

  void toggleTheme2(String gg) {
    state = state.brightness == Brightness.light ? DarkTheme() : LightTheme();
  }


  /// Material ThemeData 커스텀
  ThemeData get themeData {
    return ThemeData(
      /// Scaffold
        scaffoldBackgroundColor: state.color.surface,

        /// AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: state.color.surface,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(
            color: state.color.text,
          ),
          titleTextStyle: state.typo.headline2.copyWith(
            color: state.color.text,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        )
    );
  }
}
