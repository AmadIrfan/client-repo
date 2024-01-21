import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/utils/responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import '../theme/color_scheme.dart';
import '../ui/dashboard/file_info_card.dart';
import 'Constants.dart';

double getHeightPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.height * percent) / 100;
}

Color textPrimaryColorGlobal = Colors.black;
Color textSecondaryColorGlobal = Colors.grey;
double textBoldSizeGlobal = 16;
double textPrimarySizeGlobal = 16;
double textSecondarySizeGlobal = 14;
// String fontFamily = 'OpenSans';

FontWeight fontWeightBoldGlobal = FontWeight.bold;
FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
FontWeight fontWeightSecondaryGlobal = FontWeight.normal;

double getWidthPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width * percent) / 100;
}

InputDecoration inputDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    hintText: hintText,
    hintStyle: secondaryTextStyle(),
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: secondaryColor.withOpacity(0.4), width: 0.3)),
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: secondaryColor.withOpacity(0.4), width: 0.3)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(0.3), width: 0.3)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(0.3), width: 0.3)),
    alignLabelWithHint: true,
  );
}

TextStyle secondaryTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textSecondarySizeGlobal,
    color: color ?? textSecondaryColorGlobal,
    fontWeight: weight ?? fontWeightSecondaryGlobal,
    fontFamily: fontFamily ?? fontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

double getPercentSize(double total, double percent) {
  return (total * percent) / 100;
}

bool isNotEmpty(String s) {
  return (s.isNotEmpty);
}


bool isEmailValid(String email) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}

showToast(String string) {
  Fluttertoast.showToast(
      msg: string,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12);
}

Widget getFont(String text, {TextStyle? style, var overflow, var maxLines}) {
  return Text(
    text,
    overflow: (overflow),
    maxLines: maxLines,
    style: style == null
        ? const TextStyle(
            // fontFamily: fontFamily
            )
        : style.copyWith(
            // fontFamily: fontFamily
            ),
  );
}

Widget loaderWidget(BuildContext context,bool isVisible) {
  return nb.Loader(
    valueColor: AlwaysStoppedAnimation(primaryColor),
    color: getBackgroundColor(context),
  ).visible(isVisible);
}

getCommonButton({required Color color, required Widget widget}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.all(Radius.circular(60.r))),
    child: widget,
  );
}

getWrongButton() {
  return getCommonButton(
      color: redColor,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${Constants.assetPath}ic_close.png',
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(
            width: 2.h,
          ),
          getCustomFont('Wrong', 15.sp, Colors.white, 2,
              fontWeight: FontWeight.w600),
        ],
      ));
}

getSkipButton(BuildContext context) {
  return getCommonButton(
      color: skipColor,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${Constants.assetPath}skipped.png',
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(
            width: 2.h,
          ),
          getCustomFont('Skipped', 15.sp, Colors.black, 2,
              fontWeight: FontWeight.w600),
        ],
      ));
}

getCorrectButton() {
  return getCommonButton(
      color: greenColor,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${Constants.assetPath}right.png',
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(
            width: 2.h,
          ),
          getCustomFont('Correct', 15.sp, Colors.white, 2,
              fontWeight: FontWeight.w600),
        ],
      ));
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        // fontFamily: fontFamily,
        color: fontColor,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getDefaultFont(String text, double fontSize, Color fontColor,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        height: txtHeight,
        fontWeight: fontWeight),
    softWrap: true,
    textAlign: textAlign,
  );
}

getDefaultDecoration(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Color? shadowColor,
    double? borderWidth,
    var shape}) {
  return ShapeDecoration(
    color: (bgColor == null) ? Colors.transparent : bgColor,
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: shadowColor ?? Colors.grey.shade200,
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ],
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderWidth == null) ? 1 : borderWidth),
      borderRadius: SmoothBorderRadius(
        cornerRadius: (radius == null) ? 0 : radius,
        cornerSmoothing: 0.8,
      ),
    ),
  );
}

getTextWidget(
    {required TextEditingController dataController,
    required double height,
    required String hint,
    required Function onChange,
    bool? isEnabled,
    bool? isPassword,
    bool? isMargin,
    IconData? iconData,
    bool? isNumber}) {
  var border = InputBorder.none;

  print("number===$isNumber");
  return Container(
    height: height,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        color: Colors.transparent,
        border: Border.all(color: primaryColor, width: 0.2)),
    margin: EdgeInsets.symmetric(
        vertical: isMargin == null ? getPercentSize(height, 20) : 0),
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Theme(
      data: ThemeData(
          primaryColor: primaryColor,
          colorScheme:
              ThemeData().colorScheme.copyWith(secondary: primaryColor)),
      child: isNumber != null
          ? TextField(
              cursorColor: primaryColor,
              textAlign: TextAlign.start,
              controller: dataController,
              maxLines: 1,
              minLines: 1,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              enabled: isEnabled ?? true,
              onChanged: (value) {
                onChange(value);
              },
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  border: border,
                  hintText: hint,
                  suffixIcon: (iconData == null) ? Container() : Icon(iconData),
                  disabledBorder: border,
                  focusedBorder: border,
                  enabledBorder: border),
            )
          : TextField(
              cursorColor: primaryColor,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: dataController,
              maxLines: 1,
              minLines: 1,
              obscureText: (isPassword == null) ? false : true,
              enabled: isEnabled ?? true,
              onChanged: (value) {
                onChange(value);
              },
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.transparent,
                  border: border,
                  filled: true,
                  contentPadding: const EdgeInsets.all(0),
                  suffixIcon: (iconData == null) ? Container() : Icon(iconData),
                  hintText: hint,
                  disabledBorder: border,
                  focusedBorder: border,
                  enabledBorder: border),
            ),
    ),
  );
}

getProgressDialog(BuildContext context,{ Color? color1 }) {
  return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child:  Center(child: CupertinoActivityIndicator(color: color1 == null ?Colors.grey:color1,)));
}

Widget getErrorBuilder() {
  return Container(
    color: Colors.grey.shade200,
  );
}

getCustomTextFiled(String isError,
    {required TextEditingController textEditingController,
    required BuildContext context,
    required String hint,
    IconData? iconData,
    bool? isPassword,
    Color? color}) {
  return Theme(
    data: ThemeData(
      colorScheme: ThemeData(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ).colorScheme.copyWith(
            primary: primaryColor,
          ),
    ),
    child: TextField(
      obscureText: isPassword ?? false,
      controller: textEditingController,
      cursorColor: primaryColor,
      style: TextStyle(
          color: getFontColor(context), fontSize: 15, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          fillColor: color ?? Colors.transparent,
          filled: color != null,
          focusedErrorBorder: getBorder(color: Colors.redAccent, radius: 10.r),
          enabledBorder: getBorder(color: Colors.transparent, radius: 10.r),
          border: getBorder(color: Colors.transparent, radius: 10.r),
          focusedBorder: getBorder(color: Colors.transparent, radius: 10.r),
          disabledBorder: getBorder(color: Colors.transparent, radius: 10.r),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: iconData == null ? 0 : 10),
            child: iconData == null
                ? const Icon(
                    Icons.add,
                    size: 0,
                  )
                : Icon((iconData),color: Colors.grey.shade700),
          ),
          hintText: isError.isEmpty ? hint : isError,
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 15)),
    ),
  );
}

getAddCustomTextFiled(BuildContext context,String isError,
    {required TextEditingController textEditingController,
    required String hint,
    required IconData iconData,
    bool? isPassword,
    Color? color}) {
  return Theme(
    data: ThemeData(
      colorScheme: ThemeData(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ).colorScheme.copyWith(
            primary: primaryColor,
          ),
    ),
    child: TextField(
      obscureText: isPassword ?? false,
      controller: textEditingController,
      cursorColor: primaryColor,
      keyboardType: TextInputType.multiline,
      maxLength: null,
      style: TextStyle(
        color: getFontColor(context)
      ),
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          fillColor: color ?? Colors.transparent,
          filled: color != null,
          focusedErrorBorder: getBorder(color: Colors.transparent),
          enabledBorder: getBorder(color: Colors.transparent),
          border: getBorder(color: Colors.transparent),
          focusedBorder: getBorder(color: Colors.transparent),
          disabledBorder: getBorder(),
          hintText: isError.isEmpty ? hint : isError,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15)),
    ),
  );
}

getBorder({Color? color, double? radius}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 50),
      borderSide: BorderSide(
          color: color ?? Colors.grey.shade300, width: 1));
}

getBrowseButton(
    {required TextEditingController textEditingController,
    required Function function}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: TextField(
      enabled: false,
      controller: textEditingController,
      cursorColor: primaryColor,
      style: const TextStyle(color: Colors.white),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        fillColor: primaryColor,
        filled: true,
        focusedErrorBorder: getBorder(color: Colors.transparent),
        enabledBorder: getBorder(color: Colors.transparent),
        border: getBorder(color: Colors.transparent),
        focusedBorder: getBorder(color: Colors.transparent),
        disabledBorder: getBorder(color: Colors.transparent),
      ),
    ),
  );
}


getDefaultButton(BuildContext context, String s, Function function) {
  final Size _size = MediaQuery.of(context).size;

  return Responsive(
    mobile: getButton(_size.width < 650 ? 35 : 55, s, function, context),
    tablet: getButton(45, s, function, context),
    desktop: getButton(_size.width < 1400 ? 35 : 45, s, function, context),
  );
}

getButton(double height, String s, Function function, BuildContext context,
    {bool? isMobile}) {
  bool isDesk = isMobile == null;
  return InkWell(
    onTap: () async {
      function();
    },
    child: Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: getPercentSize(height, 20)),
      padding: EdgeInsets.symmetric(
          horizontal: getPercentSize(height, isDesk ? 30 : 5)),
      decoration: getDefaultDecoration(
          bgColor: primaryColor, radius: getPercentSize(height, 10)),
      child: Center(
        child: getFont(
          s,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: isDesk ? FontWeight.w400 : FontWeight.w600,
              fontSize: getPercentSize(height, isDesk ? 35 : 23)),
        ),
      ),
    ),
  );
}
Widget dialogWidget(BuildContext context,String title,String subTitle) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(subTitle, style: TextStyle(
        fontWeight: FontWeight.bold,
        color: getFontColor(context)
          ,
        fontSize: 17.h
      ),  ),

      6.height,
      Text(title, style: TextStyle(
          fontWeight: FontWeight.w600,
          color: themeController.isDarkTheme?Colors.grey:Colors.black54         ,
          fontSize: 14.h
      ),  ),

    ],
  );
}
getCommonDialog(
    {required BuildContext context,
    required String title,
    required String subTitle,
    required Function function}) {


  // Nb.showConfirmDialogCustom(context, onAccept: (p0) {
  //
  // });
  // Nb.showConfirmDialog(context, title, buttonColor: primaryColor).then((value) {
  //   if (value ?? false) {
  //     function();
  //   }
  // });

  nb.showInDialog(context,
      builder: (_) => dialogWidget(context,title,subTitle),
    actions: [
      InkWell(
        onTap: (){
          Get.back();
          Future.delayed(const Duration(milliseconds: 500),(){
            function();
          });
        },
        child: Text('Ok',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: getFontColor(context),
              fontSize: 12.h
          ),
        ).marginOnly(bottom: 10.h),
      ),

      15.width,

      InkWell(
        onTap: (){
         Get.back();
        },
        child: Text('Cancel',style: TextStyle(
            fontWeight: FontWeight.w600,
            color: getFontColor(context),
            fontSize: 13.h
        ),
        ).marginOnly(bottom: 10.h,right: 5.h),
      ),
    ]
);

}
