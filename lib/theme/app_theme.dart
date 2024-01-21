import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color appBackgroundColor = "#FFFFFF".toColor();
Color cardColor = "#F4F4F4".toColor();
Color darkBackgroundColor = "#1E1F25".toColor();
Color darkCardColor = "#2F2F38".toColor();
Color color1 = "#B6AAFF".toColor();
Color color2 = "#FF6A9F".toColor();
Color color3 = "#81BCF0".toColor();
Color color4 = "#F5BEA6".toColor();
Color color5 = "#FCCA49".toColor();
Color color6 = "#88C734".toColor();

Color color7 = "#8EDCE9".toColor();
Color color8 = "#DB89DD".toColor();
Color color9 = "#6FC993".toColor();
Color subBackgroundColor = "#F4F4F4".toColor();
Color subDarkBackgroundColor = "#111111".toColor();





Color primaryColor = "#389B61".toColor();
Color progressColor = "#F4F4F4".toColor();
Color redAlphaColor = "#FFE9E9".toColor();
Color greenAlphaColor = "#E9FDE4".toColor();



class AppTheme {




  static ThemeData get theme {
    ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor:primaryColor,
      // backgroundColor: appBackgroundColor,
      scaffoldBackgroundColor: subBackgroundColor,
      cardColor: cardColor,

      brightness: Brightness.light,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      appBarTheme:  const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: primaryColor,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,



      scaffoldBackgroundColor: subDarkBackgroundColor,
      cardColor: darkCardColor,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}
extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
