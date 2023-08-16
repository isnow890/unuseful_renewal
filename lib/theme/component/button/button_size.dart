part of 'button.dart';




/// 버튼 크기
enum ButtonSize {
  small,
  medium,
  large;

  double get padding {
    switch (this) {
      case ButtonSize.small:
        return 8;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
        return 16;
    }
  }

  TextStyle getTextStyle(BuildContext context, WidgetRef ref) {

    final theme = ref.watch(themeServiceProvider);

    switch (this) {
      case ButtonSize.small:
        return theme.typo.subtitle2;
      case ButtonSize.medium:
        return theme.typo.subtitle1;
      case ButtonSize.large:
        return theme.typo.headline6;
    }
  }
}