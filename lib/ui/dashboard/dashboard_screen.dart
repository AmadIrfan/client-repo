import 'package:flutter/material.dart';
import 'package:quizapp/theme/color_scheme.dart';
import 'package:quizapp/utils/responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../main.dart';
import '../../provider/data_controller.dart';
import '../../utils/Constants.dart';
import '../../utils/widgets.dart';
import 'file_info_card.dart';

const defaultPadding = 25.0;
double defaultHeight = 20.0;
const defaultHorPadding = 18.0;


class DashboardScreen extends StatelessWidget {
  final Function function;

  DashboardScreen({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    Widget itemWidget(Color textColor,Color bgColor, String title, String desc, String icon,String mask,
        {required Function onTap}) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: 380,
          height: 160.h,
          decoration: BoxDecoration(
            color: themeController.isDarkTheme?getCardColor(context):bgColor,

            borderRadius: BorderRadius.all(Radius.circular(13.r)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),

          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  height: 38.h,
                  width: 38.h,
                  decoration: BoxDecoration(
                    color: textColor,shape: BoxShape.circle
                  ),
                  alignment: Alignment.center,
                  child:  Image.asset(
                    Constants.assetDashboardPath+icon,
                    color:
                    Colors.white,
                    height: 20.h,
                    width: 20.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                  7.height,
                  getFont(
                    desc,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: getFontColor(context), fontWeight: FontWeight.w700),
                  ),
                  5.height,
                  getFont(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: getFontColor(context), fontWeight: FontWeight.w400),
                  ),

              ],),

              Align(
                alignment: Alignment.bottomRight,
                child: themeController.isDarkTheme?
                Image.asset(
                  Constants.assetIconPath+mask,
                  fit: BoxFit.scaleDown,
                  color: getIconColor(context),
                ) : Image.asset(
                  Constants.assetIconPath+mask,
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          ),


        ).onTap(onTap, borderRadius: nb.radius(25.r)),
      );
    }

    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: defaultHorPadding,horizontal: Constants.getPaddingForPage()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => getFont(
                "Hi, ${profileController.username.value}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: getFontColor(context), fontWeight: FontWeight.w500),
              ),),

              15.verticalSpace,

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getFont(
                    "Welcome Back",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: getFontColor(context), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 20.h,),
                  Image.asset("${Constants.assetIconPath}hello.png",height: 32.h,width: 32.h ),

                ],
              ), 30.verticalSpace,


              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 30.h, horizontal: 30.h),
                decoration: getDefaultDecoration(
                    bgColor: getBackgroundColor(context),
                    radius: 10.r),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Dashboard',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                          color: getFontColor(context),
                          fontWeight: FontWeight.w700),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: defaultPadding),
                              GetBuilder<DataController>(
                                builder: (sController) {
                                  return Wrap(
                                    spacing: 16.h,
                                    runSpacing: 16.h,
                                    children: [
                                      itemWidget(
                                        color1,
                                        bgColor1,
                                        'Total Categories',
                                        sController.categoryList.length.toString(),
                                        'category.png',
                                      "mask1.png",
                                        onTap: () {
                                          function(Constants.categoryView);
                                        },
                                      ),
                                      itemWidget(
                                        color2,
                                        bgColor2,
                                        'Total Quiz',
                                        sController.quizList.length.toString(),
                                        'question-mark.png',
                                        "mask2.png",
                                        onTap: () {
                                          // Get.toNamed(KeyUtil.totalQuiz);
                                          function(Constants.allQuestion);
                                        },
                                      ),
                                      itemWidget(
                                        color3,
                                        bgColor3,
                                        'Total Users',
                                        sController.userList.length.toString(),
                                        'users.png',
                                        "mask3.png",
                                        onTap: () {
                                          function(Constants.userView);
                                        },
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(width: defaultPadding),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
