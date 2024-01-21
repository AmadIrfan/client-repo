import 'package:flutter/material.dart';



import '../main.dart';
import 'app_theme.dart';

extension CustomColorScheme on ColorScheme {
  Color get backgroundColor =>
      brightness == Brightness.light ? appBackgroundColor : darkBackgroundColor;

  Color get fontColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  Color get cardBgColor =>
      brightness == Brightness.light ? cardColor : darkCardColor;

  Color get dialogBgColor =>
      brightness == Brightness.light ? cardColor : darkCardColor;

  Color get shadowColor => brightness == Brightness.light
      ? Colors.black12.withOpacity(0.1)
      : Colors.transparent;
}

Color getPrimaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

Color getAlphaPrimaryColor(BuildContext context) {
  return themeController.themeMode == ThemeMode.dark? Theme.of(context).primaryColor :"#A596FF".toColor();
}

Color getBorderColor(BuildContext context) {
  return themeController.themeMode == ThemeMode.dark? "#131517".toColor() : "#E3E7EF".toColor();
}

Color getIconColor(BuildContext context) {
  return "#727787".toColor();
}


Color getShadowColor(BuildContext context) {
  return Theme.of(context).colorScheme.shadowColor;
}

Color getFontColor(BuildContext context) {
  return Theme.of(context).colorScheme.fontColor;
}

Color getThemeColor(BuildContext context,Color color) {
  return themeController.isDarkTheme?getCardColor(context):color;
}
getBackgroundColor(BuildContext context) {
  return Theme.of(context).colorScheme.backgroundColor;
}

getDefaultBackgroundColor(BuildContext context) {
  return Theme.of(context).scaffoldBackgroundColor;
}


getCardColor(BuildContext context) {
  return Theme.of(context).colorScheme.cardBgColor;
}

getDialogBgColor(BuildContext context) {
  return Theme.of(context).colorScheme.dialogBgColor;
}



