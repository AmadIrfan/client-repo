import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/provider/data/FirebaseData.dart';
import 'package:quizapp/ui/dashboard/dashboard_screen.dart';
import 'package:quizapp/utils/pref_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizapp/utils/responsive.dart' as res;

import '../provider/obs_controller.dart';
import '../theme/color_scheme.dart';
import '../utils/Constants.dart';
import '../utils/app_routes.dart';
import '../utils/login_button.dart';
import '../utils/widgets.dart';


class SideMenu extends StatelessWidget {
  final Function function;

  SideMenu({
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ObsController obsController = Get.find();

    return Drawer(
      elevation: 3,
      backgroundColor: getBackgroundColor(context),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                // Obx(() {
                //
                //
                //     return DrawerHeader(
                //       child:Column(
                //         mainAxisSize: MainAxisSize.max,
                //         mainAxisAlignment:MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           InkWell(
                //             onTap: (){
                //             },
                //             child: Container(
                //               height: 60,
                //               width: 60,
                //               child:  profileController.imageUrl.value.isEmpty? Image.asset("${Constants.assetPath}profile.png",
                //               ):
                //               Image.asset("${Constants.assetPath}profile.png",
                //                 ),
                //             ),
                //           ),
                //           SizedBox(height: (defaultPadding/2),),
                //           getFont(
                //                 //             profileController.username.value,
                //                 //             style: Theme.of(context)
                //                 //                 .textTheme
                //                 //                 .bodyMedium!
                //                 //                 .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                //                 //           ),
                //         ],
                //       ),
                //     );
                // }),

                !res.Responsive.isDesktop(context)
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultHorPadding, vertical: 20.h),
                        child: Row(
                          children: [
                            Image.asset(
                              "${Constants.assetIconPath}logo.png",
                              height: 18.h,
                              width: 18.h,
                            color: getFontColor(context)
                ),
                            SizedBox(
                              width: 7.h,
                            ),

                            Expanded(child: getFont('Quiz'.toUpperCase(),
                                maxLines: 1,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                    color: getFontColor(context),
                                    fontWeight: FontWeight.w700)),flex: 1,)


                          ],
                        ),
                      )
                    : Container(),

                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "${Constants.assetDashboardPath}home.png",
                  press: () {
                    function(Constants.dashboardView);
                  },
                  isSelected:
                      obsController.index.value == Constants.dashboardView,
                ),
                DrawerListTile(
                  title: "Category",
                  svgSrc: "${Constants.assetDashboardPath}category.png",
                  press: () {
                    function(Constants.categoryView);
                  },
                  isSelected: obsController.index.value ==
                          Constants.categoryView ||
                      obsController.index.value == Constants.addCategoryView ||
                      obsController.index.value == Constants.editCategory,
                ),

                DrawerListTile(
                  title: "Questions",
                  svgSrc: "${Constants.assetDashboardPath}question-mark.png",
                  press: () {
                    function(Constants.allQuestion);
                  },
                  isSelected: obsController.index.value ==
                          Constants.allQuestion ||
                      obsController.index.value == Constants.addQuestionView ||
                      obsController.index.value == Constants.editQuestion,
                ),

                DrawerListTile(
                  title: "Users",
                  svgSrc: "${Constants.assetDashboardPath}users.png",
                  press: () {
                    function(Constants.userView);
                  },
                  isSelected: obsController.index.value == Constants.userView,
                ),
                DrawerListTile(
                  title: "Change Password",
                  svgSrc: "${Constants.assetDashboardPath}key.png",
                  press: () {
                    if (!res.Responsive.isDesktop(context)) {
                      Get.back();
                    }

                    PrefData.checkAccess(function: () {
                      _displayTextInputDialog(context);
                    });
                  },
                  isSelected: false,
                ),
                DrawerListTile(
                  title: "Log out",
                  svgSrc: "${Constants.assetDashboardPath}log-out-circle.png",
                  press: () {
                    PrefData.setLogin(false, '', false);
                    FirebaseAuth.instance.signOut();
                    Get.toNamed(KeyUtil.loginPage);
                    showToast("Log out");
                  },
                  isSelected: false,
                ),
              ],
            ),
          ),
          Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 3.h),
            margin: EdgeInsets.symmetric(horizontal: 25.h,vertical: 15.h),
            decoration: getDefaultDecoration(
              radius: 10.r,
              bgColor: getDefaultBackgroundColor(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getCell(context, "Light", 'light.png', !themeController.isDarkTheme,(){
                  themeController.changeTheme(ThemeMode.light);
                }),

                getCell(context, "Dark", 'dark.png',themeController.isDarkTheme, (){
                  themeController.changeTheme(ThemeMode.dark);
                })

              ],
            ),
          )
        ],
      ),
    );
  }
  
  getCell(BuildContext context,String title,String icon,bool isSelected,Function function){
    
    return Expanded(flex: 1,
      child: InkWell(
        onTap: (){
          function();
        },
        child: Container(
          height: double.infinity,
          decoration: getDefaultDecoration(
            radius: 10.r,
            bgColor:isSelected?getBackgroundColor(context):Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Constants.assetIconPath+icon,height: 18.h,width: 18.h,color: isSelected?getFontColor(context) :getIconColor(context)),
              SizedBox(width: 7.h,),
              getFont(title,maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                      color:isSelected?getFontColor(context) : getIconColor(context),
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController textFieldController = TextEditingController();
    TextEditingController textFieldController1 = TextEditingController();
    print("res===${res.Responsive.isSmallDesktop(context)}====${res.Responsive.isDesktop(context)}");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: getFont('Change Password',style: const TextStyle(fontSize: 0)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            backgroundColor: getBackgroundColor(context),

            contentPadding: EdgeInsets.zero,



            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.h,vertical: 15.h),
              width: res.Responsive.isDesktop(context) ||res.Responsive.isSmallDesktop(context)? 450.h: double.infinity,

              // decoration: getDefaultDecoration(
              //     bgColor: getBackgroundColor(context),
              //     radius: 10.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                     children: [
                       Expanded(child: getFont('Change Password',style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: getFontColor(context),
                         fontSize: 20.h
                       ))),


                       InkWell(
                         onTap: (){
                           Get.back();
                         },
                         child: Icon(
                           Icons.close,
                           size: 20.h,
                           color: getFontColor(context),
                         ),
                       ),
                     ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),

                  Text(
                    'New Password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  getCustomTextFiled('',
                            textEditingController:
                            textFieldController,
                            context: context,
                            hint: 'New Password',
                            color: getCardColor(context),
                            iconData: Icons.lock_outline,
                            isPassword: true),



                  // TextField(
                  //   onChanged: (value) {},
                  //   obscureText: true,
                  //   controller: _textFieldController,
                  //   decoration: InputDecoration(hintText: "New Password"),
                  // ),
                  SizedBox(
                    height: 18.h,
                  ),


                  Text(
                    'Confirm Password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  getCustomTextFiled('',
                      textEditingController:
                      textFieldController1,
                      context: context,
                      hint: 'Confirm Password',
                      color: getCardColor(context),
                      iconData: Icons.lock_outline,
                      isPassword: true),

                  SizedBox(
                    height: 25.h,
                  ),

                  LoginButton(onChanged: () async {

                          String password1 = textFieldController.text;
                          String password2 = textFieldController1.text;
                          if (isNotEmpty(password1) && isNotEmpty(password2)) {
                            if (password1.length > 6) {
                              if (password1 == password2) {
                                FirebaseData.changePassword(
                                    password: password1,
                                    function: () {
                                      Get.back();
                                    });
                              } else {
                                showToast("Password does not match");
                              }
                            } else {
                              showToast("You must have 6 characters in your password");
                            }
                          } else {
                            showToast("Fill Detail..");
                          }

                  },title: 'Update'),

                  SizedBox(
                    height: 25.h,
                  ),

                  // TextField(
                  //   obscureText: true,
                  //   onChanged: (value) {},
                  //   controller: _textFieldController1,
                  //   decoration: InputDecoration(hintText: "Confirm Password"),
                  // ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   TextButton(
            //     child: getFont('Cancel', style: TextStyle(color: primaryColor)),
            //     onPressed: () {
            //       Get.back();
            //     },
            //   ),
            //   TextButton(
            //     child: getFont('Ok', style: TextStyle(color: primaryColor)),
            //     onPressed: () async {
            //       String password1 = _textFieldController.text;
            //       String password2 = _textFieldController1.text;
            //       if (isNotEmpty(password1) && isNotEmpty(password2)) {
            //         if (password1.length > 6) {
            //           if (password1 == password2) {
            //             FirebaseData.changePassword(
            //                 password: password1,
            //                 function: () {
            //                   Get.back();
            //                 });
            //           } else {
            //             showToast("Password does not match");
            //           }
            //         } else {
            //           showToast("You must have 6 characters in your password");
            //         }
            //       } else {
            //         showToast("Fill Detail..");
            //       }
            //     },
            //   ),
            // ],
          );
        });
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = themeController.isDarkTheme;
    final Color color = themeController.isDarkTheme? getFontColor(context):getPrimaryColor(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: (defaultHorPadding / 2), horizontal: defaultHorPadding),
      padding:
          EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.h),
      decoration: getDefaultDecoration(
        radius: 12.r,
        bgColor: !isSelected
            ? Colors.transparent
            : isDarkTheme?getDefaultBackgroundColor(context):getPrimaryColor(context).withOpacity(0.1),
      ),
      child: InkWell(
        onTap: () {
          press();
        },
        child: Row(
          children: [
            Image.asset(
              svgSrc,
              color:
                  isSelected ? color: getIconColor(context),
              height: 18.h,
              width: 18.h,
              fit: BoxFit.scaleDown,
            ),
            15.width,
            Expanded(child: getFont(
              title,maxLines: 1,
              style: TextStyle(overflow: TextOverflow.ellipsis,
                  color: isSelected
                      ? color
                      : getIconColor(context),
                  fontWeight: FontWeight.w400),
            ),flex: 1,)
          ],
        ),
      ),
    );
  }
}
