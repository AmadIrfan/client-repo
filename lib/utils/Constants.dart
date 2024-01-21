import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants{


  static String assetPath='assets/images/';
  static String assetIconPath='assets/icons/';
  static String assetDashboardPath='assets/dashboard/';
  static int dashboardView=0;
  static int categoryView=1;
  static int addCategoryView=2;
  static int addQuestionView=3;
  static int allQuestion=7;
  static int userView=4;
  static int changePassword=5;
  static int logout=6;
  static int editCategory=8;
  static int editQuestion=9;
  static int testData=10;
  static int testDetail=11;



  static getPaddingForPage(){
    return 15.w;
  }

  static void setupSize(BuildContext context,
      {double width = 414, double height = 896}) {
    ScreenUtil.init(context,
        designSize: Size(width, height), minTextAdapt: true);
  }
}

String getSeconds(int sec) {
  if (sec == 0) {
    return "00:00";
  }
  int second = sec % 60;
  double minute = sec / 60;
  if (minute >= 60) {
    return  second.toInt().toString();
  }
  return second.toInt().toString();
}

String getMinute(int sec) {
  if (sec == 0) {
    return "00:00";
  }
  double minute = sec / 60;
  if (minute >= 60) {
    minute %= 60;
    return minute.toInt().toString();
  }
  return minute.toInt().toString();
}
