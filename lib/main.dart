import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../provider/data/FirebaseData.dart';
import '../../provider/data/LoginData.dart';
import '../../provider/data_controller.dart';
import '../../provider/obs_controller.dart';
import '../../provider/profile_controller.dart';
import '../../theme/app_theme.dart';
import '../../theme/color_scheme.dart';
import '../../theme/controller/theme_controller.dart';
import '../../ui/category/add_category_view.dart';
import '../../ui/category/edit_category_view.dart';
import '../../ui/quiz/edit_question_view.dart';
import '../../ui/totalquiz/total_question_view.dart';
import '../../ui/users/test_detail.dart';
import '../../ui/users/test_list.dart';
import '../../ui/users/user_list.dart';
import '../../utils/Constants.dart';
import '../../utils/app_routes.dart';
import '../../utils/login_button.dart';
import '../../utils/pref_data.dart';
import '../../utils/responsive.dart' as res;
import '../../ui/category/category_view.dart';
import '../../ui/dashboard/dashboard_screen.dart';
import '../../ui/quiz/add_question_view.dart';
import '../../ui/side_menu.dart';
import '../../utils/widgets.dart';
import 'firebase_options.dart';

ThemeController themeController = Get.put(ThemeController());
final ProfileController profileController = Get.put(ProfileController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  // if (kIsWeb) {
  //   print('here');
  //   // await Firebase.initializeApp(
  //   //     options: const FirebaseOptions(
  //   //         apiKey: "AIzaSyD9hNXqGbGRmS2LVXZyMTf1fPNcZJ0HXiw",
  //   //         authDomain: "quizapp-ec9a8.firebaseapp.com",
  //   //         projectId: "quizapp-ec9a8",
  //   //         storageBucket: "quizapp-ec9a8.appspot.com",
  //   //         messagingSenderId: "1065554970369",
  //   //         appId: "1:1065554970369:web:9ebc025d0c9fce78c13d00",
  //   //         measurementId: "G-XHTSYQ1M9D"));
  // } else {
  //   await Firebase.initializeApp();
  // }

  runApp(const MyApp());
}

Future<bool> checkIfDocExists(String docId) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance
        .collection("${FirebaseData.historyList}/$docId");

    return collectionRef.path.isNotEmpty;
  } catch (e) {
    rethrow;
  }
}
//Good

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Constants.setupSize(context);
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (BuildContext context, Widget? child) {
        return GetBuilder<ThemeController>(
          init: ThemeController(),
          builder: (controller) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              scrollBehavior: MyCustomScrollBehavior(),
              theme: AppTheme.theme,
              darkTheme: AppTheme.darkTheme,
              themeMode: controller.themeMode,
              routes: appRoutes,
              initialRoute: KeyUtil.splash,
            );
          },
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  ValueNotifier<String> isEmailError = ValueNotifier('');
  ValueNotifier<String> isPassError = ValueNotifier('');

  @override
  void initState() {
    super.initState();
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController signUpUserNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  RxBool isSignUp = false.obs;
  RxBool isProcess = false.obs;

  @override
  Widget build(BuildContext context) {
    print("li====${MediaQuery.of(context).size.width}");
    return WillPopScope(
      onWillPop: () async {
        exitApp();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: getDefaultBackgroundColor(context),
          title: getFont(' '),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            color: getDefaultBackgroundColor(context),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (res.Responsive.isDesktop(context))
                  Expanded(
                    child: Container(
                      color: getDefaultBackgroundColor(context),
                    ),
                    flex: 1,
                  ),
                // StreamBuilder<QuerySnapshot>(
                //   stream: FirebaseFirestore.instance
                //       .collection(FirebaseData.adminData)
                //       .snapshots(),
                //   builder: (context, snapshot) {
                //     print("snap12112------------${snapshot.data}===${snapshot.connectionState}");
                //
                //     if (snapshot.data == null &&
                //         snapshot.connectionState == ConnectionState.waiting) {
                //       // print("snap------------waiting");
                //
                //       return Container();
                //     } else if (snapshot.data != null &&  snapshot.data!.docs.isEmpty &&
                //         snapshot.connectionState == ConnectionState.active) {
                //       // print("snap------------active----null");
                //       return Expanded(
                //         flex: res.Responsive.isMediumDesktop(context) ? 2 : 1,
                //         child: Container(
                //           margin: EdgeInsets.symmetric(
                //               horizontal: res.Responsive.isDesktop(context)
                //                   ? (60.h)
                //                   : (40.h)),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Sign Up',
                //                 textAlign: TextAlign.center,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .titleLarge!
                //                     .copyWith(
                //                     color: getFontColor(context),
                //                     fontWeight: FontWeight.w700),
                //               ),
                //               const SizedBox(
                //                 height: (defaultPadding * 2),
                //               ),
                //               Container(
                //                 padding: EdgeInsets.symmetric(
                //                     vertical: 50.h, horizontal: 30.h),
                //                 decoration: getDefaultDecoration(
                //                     bgColor: getBackgroundColor(context),
                //                     radius: 10.r),
                //                 child: Column(
                //                   crossAxisAlignment:
                //                   CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       'Username',
                //                       textAlign: TextAlign.center,
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .labelLarge!
                //                           .copyWith(
                //                           color: Colors.grey.shade600,
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                     SizedBox(
                //                       height: 8.h,
                //                     ),
                //                     ValueListenableBuilder(
                //                         builder: (context, value, child) {
                //                           return getCustomTextFiled(
                //                               context: context,
                //                               isEmailError.value,
                //                               textEditingController:
                //                               signUpUserNameController,
                //                               hint: 'Enter your username',
                //                               color: getCardColor(context));
                //                         },
                //                         valueListenable: isEmailError),
                //                     const SizedBox(
                //                       height: defaultHorPadding,
                //                     ),
                //                     Text(
                //                       'Email',
                //                       textAlign: TextAlign.center,
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .labelLarge!
                //                           .copyWith(
                //                           color: Colors.grey.shade600,
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                     SizedBox(
                //                       height: 8.h,
                //                     ),
                //                     ValueListenableBuilder(
                //                         builder: (context, value, child) {
                //                           return getCustomTextFiled(
                //                               context: context,
                //                               isEmailError.value,
                //                               textEditingController:
                //                               signUpEmailController,
                //                               hint:
                //                               'Enter your email address',
                //                               color: getCardColor(context));
                //                         },
                //                         valueListenable: isEmailError),
                //                     const SizedBox(
                //                       height: defaultHorPadding,
                //                     ),
                //                     Text(
                //                       'Password',
                //                       textAlign: TextAlign.center,
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .labelLarge!
                //                           .copyWith(
                //                           color: Colors.grey.shade600,
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                     SizedBox(
                //                       height: 8.h,
                //                     ),
                //                     ValueListenableBuilder(
                //                         builder: (context, value, child) {
                //                           return getCustomTextFiled(
                //                               isPassError.value,
                //                               textEditingController:
                //                               signUpPasswordController,
                //                               context: context,
                //                               hint: 'Password',
                //                               color: getCardColor(context),
                //                               iconData: Icons.lock_outline,
                //                               isPassword: true);
                //                         },
                //                         valueListenable: isEmailError),
                //                     const SizedBox(
                //                       height: defaultHorPadding,
                //                     ),
                //                     Text(
                //                       'Confirm Password',
                //                       textAlign: TextAlign.center,
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .labelLarge!
                //                           .copyWith(
                //                           color: Colors.grey.shade600,
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                     SizedBox(
                //                       height: 8.h,
                //                     ),
                //                     ValueListenableBuilder(
                //                         builder: (context, value, child) {
                //                           return getCustomTextFiled(
                //                               isPassError.value,
                //                               textEditingController:
                //                               signUpConfirmPasswordController,
                //                               context: context,
                //                               hint: 'Confirm Password',
                //                               color: getCardColor(context),
                //                               iconData: Icons.lock_outline,
                //                               isPassword: true);
                //                         },
                //                         valueListenable: isEmailError),
                //                     SizedBox(
                //                       height: 30.h,
                //                     ),
                //                     LoginButton(
                //                         onChanged: () async {
                //                           if (isNotEmpty(signUpUserNameController.text) &&
                //                               isNotEmpty(signUpEmailController
                //                                   .text) &&
                //                               isNotEmpty(
                //                                   signUpPasswordController
                //                                       .text) &&
                //                               isNotEmpty(
                //                                   signUpConfirmPasswordController
                //                                       .text)) {
                //                             if (isEmailValid(
                //                                 signUpEmailController.text)) {
                //                               if (signUpPasswordController
                //                                   .text.length >=
                //                                   6) {
                //                                 if (signUpPasswordController
                //                                     .text ==
                //                                     signUpConfirmPasswordController
                //                                         .text) {
                //                                   isEmailError.value = '';
                //                                   isPassError.value = '';
                //
                //                                   bool isRegister = await LoginData
                //                                       .registerUsingEmailPassword(
                //                                       email:
                //                                       signUpEmailController
                //                                           .text,
                //                                       password:
                //                                       signUpPasswordController
                //                                           .text);
                //
                //                                   if (isRegister) {
                //
                //                                     FirebaseData.createUser(
                //                                         isAdmin: true,
                //                                         password:
                //                                         signUpPasswordController
                //                                             .text,
                //                                         username:
                //                                         signUpUserNameController
                //                                             .text,
                //                                         function: () async {
                //
                //                                           // bool isLoginComplete =
                //                                           // await LoginData.login(
                //                                           //     password:
                //                                           //     signUpPasswordController
                //                                           //         .text,
                //                                           //     username:
                //                                           //     signUpUserNameController
                //                                           //         .text);
                //                                           //
                //                                           //
                //                                           // if (isLoginComplete) {
                //                                           //   LoginData.login(
                //                                           //       username:
                //                                           //       signUpUserNameController
                //                                           //           .text,
                //                                           //       password:
                //                                           //       signUpPasswordController
                //                                           //           .text);
                //                                           //   Get.toNamed(
                //                                           //       KeyUtil.home);
                //                                           //   passwordController
                //                                           //       .text = '';
                //                                           //   userNameController
                //                                           //       .text = '';
                //                                           //
                //                                           //
                //                                           // } else {
                //                                           //
                //                                           //   showToast(
                //                                           //       "Something wrong");
                //                                           //
                //                                           // }
                //
                //                                         });
                //                                   } else {
                //                                     showToast(
                //                                         "Something wrong");
                //                                   }
                //                                 } else {
                //                                   showToast(
                //                                       "Password does not match");
                //                                 }
                //                               } else {
                //                                 showToast(
                //                                     "You must have 6 character in your password");
                //                               }
                //                             } else {
                //                               showToast("Email not valid");
                //                             }
                //                           } else {
                //                             // isEmailError.value='Enter Email';
                //                             // isPassError.value='Enter Password';
                //                             showToast("Enter detail");
                //                           }
                //                         },
                //                         title: "Sign Up"),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10.h,
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     } else if (snapshot.data != null &&
                //         snapshot.connectionState == ConnectionState.active) {
                //
                //
                //       if (snapshot.data!.size > 0) {
                //         return Expanded(
                //           flex: res.Responsive.isMediumDesktop(context) ? 2 : 1,
                //           child: Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal: res.Responsive.isDesktop(context)
                //                     ? (60.h)
                //                     : (40.h)),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   'Login as a Admin user',
                //                   textAlign: TextAlign.center,
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleLarge!
                //                       .copyWith(
                //                           color: getFontColor(context),
                //                           fontWeight: FontWeight.w700),
                //                 ),
                //                 const SizedBox(
                //                   height: (defaultPadding * 2),
                //                 ),
                //                 Container(
                //                   padding: EdgeInsets.symmetric(
                //                       vertical: 50.h, horizontal: 30.h),
                //                   decoration: getDefaultDecoration(
                //                       bgColor: getBackgroundColor(context),
                //                       radius: 10.r),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         'Username',
                //                         textAlign: TextAlign.center,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .labelLarge!
                //                             .copyWith(
                //                                 color: Colors.grey.shade600,
                //                                 fontWeight: FontWeight.w600),
                //                       ),
                //                       SizedBox(
                //                         height: 8.h,
                //                       ),
                //                       ValueListenableBuilder(
                //                           builder: (context, value, child) {
                //                             return getCustomTextFiled(
                //                                 context: context,
                //                                 isEmailError.value,
                //                                 textEditingController:
                //                                     userNameController,
                //                                 hint: 'Enter your username',
                //                                 color: getCardColor(context));
                //                           },
                //                           valueListenable: isEmailError),
                //                       const SizedBox(
                //                         height: defaultHorPadding,
                //                       ),
                //                       Text(
                //                         'Password',
                //                         textAlign: TextAlign.center,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .labelLarge!
                //                             .copyWith(
                //                                 color: Colors.grey.shade600,
                //                                 fontWeight: FontWeight.w600),
                //                       ),
                //                       SizedBox(
                //                         height: 8.h,
                //                       ),
                //                       ValueListenableBuilder(
                //                           builder: (context, value, child) {
                //                             return getCustomTextFiled(
                //                                 isPassError.value,
                //                                 textEditingController:
                //                                     passwordController,
                //                                 context: context,
                //                                 hint: 'Password',
                //                                 color: getCardColor(context),
                //                                 iconData: Icons.lock_outline,
                //                                 isPassword: true);
                //                           },
                //                           valueListenable: isEmailError),
                //                       SizedBox(
                //                         height: 30.h,
                //                       ),
                //                       LoginButton(onChanged: () async {
                //                         if (isNotEmpty(
                //                                 userNameController.text) &&
                //                             isNotEmpty(
                //                                 passwordController.text)) {
                //                           isEmailError.value = '';
                //                           isPassError.value = '';
                //                           bool isLoginComplete =
                //                               await LoginData.login(
                //                                   password:
                //                                       passwordController.text,
                //                                   username:
                //                                       userNameController.text);
                //
                //                           if (isLoginComplete) {
                //                             profileController.getProfileImage();
                //                             Get.toNamed(KeyUtil.home);
                //                             passwordController.text = '';
                //                             userNameController.text = '';
                //                           } else {
                //                             showToast("Something wrong");
                //                           }
                //                         } else {
                //                           // isEmailError.value='Enter Email';
                //                           // isPassError.value='Enter Password';
                //                           showToast("Enter detail");
                //                         }
                //                       }),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   height: 10.h,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       } else {
                //         return Expanded(
                //           flex: res.Responsive.isMediumDesktop(context) ? 2 : 1,
                //           child: Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal: res.Responsive.isDesktop(context)
                //                     ? (60.h)
                //                     : (40.h)),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   'Sign Up',
                //                   textAlign: TextAlign.center,
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleLarge!
                //                       .copyWith(
                //                           color: getFontColor(context),
                //                           fontWeight: FontWeight.w700),
                //                 ),
                //                 const SizedBox(
                //                   height: (defaultPadding * 2),
                //                 ),
                //                 Container(
                //                   padding: EdgeInsets.symmetric(
                //                       vertical: 50.h, horizontal: 30.h),
                //                   decoration: getDefaultDecoration(
                //                       bgColor: getBackgroundColor(context),
                //                       radius: 10.r),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         'Username',
                //                         textAlign: TextAlign.center,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .labelLarge!
                //                             .copyWith(
                //                                 color: Colors.grey.shade600,
                //                                 fontWeight: FontWeight.w600),
                //                       ),
                //                       SizedBox(
                //                         height: 8.h,
                //                       ),
                //                       ValueListenableBuilder(
                //                           builder: (context, value, child) {
                //                             return getCustomTextFiled(
                //                                 context: context,
                //                                 isEmailError.value,
                //                                 textEditingController:
                //                                     signUpUserNameController,
                //                                 hint: 'Enter your username',
                //                                 color: getCardColor(context));
                //                           },
                //                           valueListenable: isEmailError),
                //                       const SizedBox(
                //                         height: defaultHorPadding,
                //                       ),
                //                       Text(
                //                         'Email',
                //                         textAlign: TextAlign.center,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .labelLarge!
                //                             .copyWith(
                //                                 color: Colors.grey.shade600,
                //                                 fontWeight: FontWeight.w600),
                //                       ),
                //                       SizedBox(
                //                         height: 8.h,
                //                       ),
                //                       ValueListenableBuilder(
                //                           builder: (context, value, child) {
                //                             return getCustomTextFiled(
                //                                 context: context,
                //                                 isEmailError.value,
                //                                 textEditingController:
                //                                     signUpEmailController,
                //                                 hint:
                //                                     'Enter your email address',
                //                                 color: getCardColor(context));
                //                           },
                //                           valueListenable: isEmailError),
                //                       const SizedBox(
                //                         height: defaultHorPadding,
                //                       ),
                //                       Text(
                //                         'Password',
                //                         textAlign: TextAlign.center,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .labelLarge!
                //                             .copyWith(
                //                                 color: Colors.grey.shade600,
                //                                 fontWeight: FontWeight.w600),
                //                       ),
                //                       SizedBox(
                //                         height: 8.h,
                //                       ),
                //                       ValueListenableBuilder(
                //                           builder: (context, value, child) {
                //                             return getCustomTextFiled(
                //                                 isPassError.value,
                //                                 textEditingController:
                //                                     signUpPasswordController,
                //                                 context: context,
                //                                 hint: 'Password',
                //                                 color: getCardColor(context),
                //                                 iconData: Icons.lock_outline,
                //                                 isPassword: true);
                //                           },
                //                           valueListenable: isEmailError),
                //                       const SizedBox(
                //                         height: defaultHorPadding,
                //                       ),
                //                       Text(
                //                         'Confirm Password',
                //                         textAlign: TextAlign.center,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .labelLarge!
                //                             .copyWith(
                //                                 color: Colors.grey.shade600,
                //                                 fontWeight: FontWeight.w600),
                //                       ),
                //                       SizedBox(
                //                         height: 8.h,
                //                       ),
                //                       ValueListenableBuilder(
                //                           builder: (context, value, child) {
                //                             return getCustomTextFiled(
                //                                 isPassError.value,
                //                                 textEditingController:
                //                                     signUpConfirmPasswordController,
                //                                 context: context,
                //                                 hint: 'Confirm Password',
                //                                 color: getCardColor(context),
                //                                 iconData: Icons.lock_outline,
                //                                 isPassword: true);
                //                           },
                //                           valueListenable: isEmailError),
                //                       SizedBox(
                //                         height: 30.h,
                //                       ),
                //                       LoginButton(
                //                           onChanged: () async {
                //                             if (isNotEmpty(signUpUserNameController.text) &&
                //                                 isNotEmpty(signUpEmailController
                //                                     .text) &&
                //                                 isNotEmpty(
                //                                     signUpPasswordController
                //                                         .text) &&
                //                                 isNotEmpty(
                //                                     signUpConfirmPasswordController
                //                                         .text)) {
                //                               if (isEmailValid(
                //                                   signUpEmailController.text)) {
                //                                 if (signUpPasswordController
                //                                         .text.length >
                //                                     6) {
                //                                   if (signUpPasswordController
                //                                           .text ==
                //                                       signUpConfirmPasswordController
                //                                           .text) {
                //                                     isEmailError.value = '';
                //                                     isPassError.value = '';
                //
                //                                     bool isRegister = await LoginData
                //                                         .registerUsingEmailPassword(
                //                                             email:
                //                                                 signUpEmailController
                //                                                     .text,
                //                                             password:
                //                                                 signUpPasswordController
                //                                                     .text);
                //
                //                                     if (isRegister) {
                //                                       FirebaseData.createUser(
                //                                           isAdmin: true,
                //                                           password:
                //                                               signUpPasswordController
                //                                                   .text,
                //                                           username:
                //                                               signUpUserNameController
                //                                                   .text,
                //                                           function: () async {
                //
                //                                             profileController.getProfileImage();
                //                                             Get.toNamed(KeyUtil.home);
                //                                             passwordController.text = '';
                //                                             userNameController.text = '';
                //
                //                                             // bool isLoginComplete =
                //                                             //     await LoginData.login(
                //                                             //         password:
                //                                             //         signUpPasswordController
                //                                             //                 .text,
                //                                             //         username:
                //                                             //         signUpUserNameController
                //                                             //                 .text);
                //                                             //
                //                                             //
                //                                             // if (isLoginComplete) {
                //                                             //   // LoginData.login(
                //                                             //   //     username:
                //                                             //   //         signUpUserNameController
                //                                             //   //             .text,
                //                                             //   //     password:
                //                                             //   //         signUpPasswordController
                //                                             //   //             .text);
                //                                             //   profileController.getProfileImage();
                //                                             //   Get.toNamed(
                //                                             //       KeyUtil.home);
                //                                             //   passwordController
                //                                             //       .text = '';
                //                                             //   userNameController
                //                                             //       .text = '';
                //                                             //
                //                                             //
                //                                             //
                //                                             //
                //                                             //
                //                                             // } else {
                //                                             //
                //                                             //   showToast(
                //                                             //       "Something wrong");
                //                                             //
                //                                             // }
                //
                //                                           });
                //                                     } else {
                //                                       showToast(
                //                                           "Something wrong");
                //                                     }
                //                                   } else {
                //                                     showToast(
                //                                         "Password does not match");
                //                                   }
                //                                 } else {
                //                                   showToast(
                //                                       "You must have 6 character in your password");
                //                                 }
                //                               } else {
                //                                 showToast("Email not valid");
                //                               }
                //                             } else {
                //                               // isEmailError.value='Enter Email';
                //                               // isPassError.value='Enter Password';
                //                               showToast("Enter detail");
                //                             }
                //                           },
                //                           title: "Sign Up"),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   height: 10.h,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       }
                //
                //       // AdminModel admin = AdminModel.fromFirestore(snapshot.data!.docs[0]);
                //       //
                //       //
                //       // print("admin-------------${admin.toString()}");
                //       //
                //       // // List<DocumentSnapshot> list = snapshot.data!.docs;
                //
                //       // if(list[0].exists){
                //       //   if(snapshot.data!.size > 0 &&
                //       //       snapshot.data!.docs.isNotEmpty){
                //       //
                //       //     print("snap------------active-------isnotempty");
                //       //
                //       //
                //       // }else{
                //       //     return Container();
                //       //   }
                //       //
                //       // }else{
                //       //   return Expanded(
                //       //     flex: res.Responsive.isMediumDesktop(context) ? 2 : 1,
                //       //     child: Container(
                //       //       margin: EdgeInsets.symmetric(
                //       //           horizontal: res.Responsive.isDesktop(context)
                //       //               ? (60.h)
                //       //               : (40.h)),
                //       //       child: Column(
                //       //         crossAxisAlignment: CrossAxisAlignment.center,
                //       //         mainAxisAlignment: MainAxisAlignment.center,
                //       //         children: [
                //       //           Text(
                //       //             'Sign Up',
                //       //             textAlign: TextAlign.center,
                //       //             style: Theme.of(context)
                //       //                 .textTheme
                //       //                 .headline6!
                //       //                 .copyWith(
                //       //                 color: getFontColor(context),
                //       //                 fontWeight: FontWeight.w700),
                //       //           ),
                //       //           SizedBox(
                //       //             height: (defaultPadding * 2),
                //       //           ),
                //       //           Container(
                //       //             padding: EdgeInsets.symmetric(
                //       //                 vertical: 50.h, horizontal: 30.h),
                //       //             decoration: getDefaultDecoration(
                //       //                 bgColor: getBackgroundColor(context),
                //       //                 radius: 10.r),
                //       //             child: Column(
                //       //               crossAxisAlignment:
                //       //               CrossAxisAlignment.start,
                //       //               children: [
                //       //                 Text(
                //       //                   'Username',
                //       //                   textAlign: TextAlign.center,
                //       //                   style: Theme.of(context)
                //       //                       .textTheme
                //       //                       .labelLarge!
                //       //                       .copyWith(
                //       //                       color: Colors.grey.shade600,
                //       //                       fontWeight: FontWeight.w600),
                //       //                 ),
                //       //                 SizedBox(
                //       //                   height: 8.h,
                //       //                 ),
                //       //                 ValueListenableBuilder(
                //       //                     builder: (context, value, child) {
                //       //                       return getCustomTextFiled(
                //       //                           context: context,
                //       //                           isEmailError.value,
                //       //                           textEditingController:
                //       //                           userNameController,
                //       //                           hint: 'Enter your username',
                //       //                           color: getCardColor(context));
                //       //                     },
                //       //                     valueListenable: isEmailError),
                //       //                 SizedBox(
                //       //                   height: defaultHorPadding,
                //       //                 ),
                //       //                 Text(
                //       //                   'Password',
                //       //                   textAlign: TextAlign.center,
                //       //                   style: Theme.of(context)
                //       //                       .textTheme
                //       //                       .labelLarge!
                //       //                       .copyWith(
                //       //                       color: Colors.grey.shade600,
                //       //                       fontWeight: FontWeight.w600),
                //       //                 ),
                //       //                 SizedBox(
                //       //                   height: 8.h,
                //       //                 ),
                //       //                 ValueListenableBuilder(
                //       //                     builder: (context, value, child) {
                //       //                       return getCustomTextFiled(
                //       //                           isPassError.value,
                //       //                           textEditingController:
                //       //                           passwordController,
                //       //                           context: context,
                //       //                           hint: 'Password',
                //       //                           color: getCardColor(context),
                //       //                           iconData: Icons.lock_outline,
                //       //                           isPassword: true);
                //       //                     },
                //       //                     valueListenable: isEmailError),
                //       //                 SizedBox(
                //       //                   height: defaultHorPadding,
                //       //                 ),
                //       //                 Text(
                //       //                   'Confirm Password',
                //       //                   textAlign: TextAlign.center,
                //       //                   style: Theme.of(context)
                //       //                       .textTheme
                //       //                       .labelLarge!
                //       //                       .copyWith(
                //       //                       color: Colors.grey.shade600,
                //       //                       fontWeight: FontWeight.w600),
                //       //                 ),
                //       //                 SizedBox(
                //       //                   height: 8.h,
                //       //                 ),
                //       //                 ValueListenableBuilder(
                //       //                     builder: (context, value, child) {
                //       //                       return getCustomTextFiled(
                //       //                           isPassError.value,
                //       //                           textEditingController:
                //       //                           passwordController,
                //       //                           context: context,
                //       //                           hint: 'Confirm Password',
                //       //                           color: getCardColor(context),
                //       //                           iconData: Icons.lock_outline,
                //       //                           isPassword: true);
                //       //                     },
                //       //                     valueListenable: isEmailError),
                //       //                 SizedBox(
                //       //                   height: 30.h,
                //       //                 ),
                //       //                 LoginButton(onChanged: () async {
                //       //                   if (isNotEmpty(
                //       //                       userNameController.text) &&
                //       //                       isNotEmpty(
                //       //                           passwordController.text)) {
                //       //                     isEmailError.value = '';
                //       //                     isPassError.value = '';
                //       //                     bool isLoginComplete =
                //       //                     await LoginData.login(
                //       //                         password:
                //       //                         passwordController.text,
                //       //                         username:
                //       //                         userNameController.text);
                //       //
                //       //                     if (isLoginComplete) {
                //       //                       profileController.getProfileImage();
                //       //                       Get.toNamed(KeyUtil.home);
                //       //                       passwordController.text = '';
                //       //                       userNameController.text = '';
                //       //                     } else {
                //       //                       showToast("Something wrong");
                //       //                     }
                //       //                   } else {
                //       //                     // isEmailError.value='Enter Email';
                //       //                     // isPassError.value='Enter Password';
                //       //                     showToast("Enter detail");
                //       //                   }
                //       //                 }),
                //       //               ],
                //       //             ),
                //       //           ),
                //       //           SizedBox(
                //       //             height: 10.h,
                //       //           ),
                //       //         ],
                //       //       ),
                //       //     ),
                //       //   );
                //       // }
                //     } else {
                //       return Container();
                //     }
                //   },
                // ),

                Expanded(
                  flex: res.Responsive.isMediumDesktop(context) ? 2 : 1,
                  child: Obx(() {
                    if (isSignUp.value) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: res.Responsive.isDesktop(context)
                                ? (60.h)
                                : (40.h)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: getFontColor(context),
                                      fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: (defaultPadding * 2),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 50.h, horizontal: 30.h),
                              decoration: getDefaultDecoration(
                                  bgColor: getBackgroundColor(context),
                                  radius: 10.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Username',
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
                                  ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getCustomTextFiled(
                                            context: context,
                                            isEmailError.value,
                                            textEditingController:
                                                signUpUserNameController,
                                            hint: 'Enter your username',
                                            color: getCardColor(context));
                                      },
                                      valueListenable: isEmailError),
                                  const SizedBox(
                                    height: defaultHorPadding,
                                  ),
                                  Text(
                                    'Email',
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
                                  ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getCustomTextFiled(
                                            context: context,
                                            isEmailError.value,
                                            textEditingController:
                                                signUpEmailController,
                                            hint: 'Enter your email address',
                                            color: getCardColor(context));
                                      },
                                      valueListenable: isEmailError),
                                  const SizedBox(
                                    height: defaultHorPadding,
                                  ),
                                  Text(
                                    'Password',
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
                                  ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getCustomTextFiled(
                                            isPassError.value,
                                            textEditingController:
                                                signUpPasswordController,
                                            context: context,
                                            hint: 'Password',
                                            color: getCardColor(context),
                                            iconData: Icons.lock_outline,
                                            isPassword: true);
                                      },
                                      valueListenable: isEmailError),
                                  const SizedBox(
                                    height: defaultHorPadding,
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
                                  ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getCustomTextFiled(
                                            isPassError.value,
                                            textEditingController:
                                                signUpConfirmPasswordController,
                                            context: context,
                                            hint: 'Confirm Password',
                                            color: getCardColor(context),
                                            iconData: Icons.lock_outline,
                                            isPassword: true);
                                      },
                                      valueListenable: isEmailError),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  LoginButton(
                                      onChanged: () async {
                                        isProcess.value = true;
                                        if (isNotEmpty(signUpUserNameController
                                                .text) &&
                                            isNotEmpty(
                                                signUpEmailController.text) &&
                                            isNotEmpty(signUpPasswordController
                                                .text) &&
                                            isNotEmpty(
                                                signUpConfirmPasswordController
                                                    .text)) {
                                          if (isEmailValid(
                                              signUpEmailController.text)) {
                                            if (signUpPasswordController
                                                    .text.length >=
                                                6) {
                                              if (signUpPasswordController
                                                      .text ==
                                                  signUpConfirmPasswordController
                                                      .text) {
                                                isEmailError.value = '';
                                                isPassError.value = '';

                                                bool isRegister = await LoginData
                                                    .registerUsingEmailPassword(
                                                        email:
                                                            signUpEmailController
                                                                .text,
                                                        password:
                                                            signUpPasswordController
                                                                .text);

                                                if (isRegister) {
                                                  FirebaseData.createUser(
                                                      isAdmin: true,
                                                      password:
                                                          signUpPasswordController
                                                              .text,
                                                      username:
                                                          signUpEmailController
                                                              .text,
                                                      function: () async {
                                                        bool isLoginComplete =
                                                            await LoginData.login(
                                                                password:
                                                                    signUpPasswordController
                                                                        .text,
                                                                username:
                                                                    signUpEmailController
                                                                        .text);

                                                        print(
                                                            "isLoginCompe===$isLoginComplete");
                                                        if (isLoginComplete) {
                                                          Get.toNamed(
                                                              KeyUtil.home);
                                                          passwordController
                                                              .text = '';
                                                          signUpEmailController
                                                              .text = '';
                                                        } else {
                                                          showToast(
                                                              "Something wrong");
                                                        }
                                                      });
                                                } else {
                                                  showToast("Something wrong");
                                                }
                                              } else {
                                                showToast(
                                                    "Password does not match");
                                              }
                                            } else {
                                              showToast(
                                                  "You must have 6 character in your password");
                                            }
                                          } else {
                                            showToast("Email not valid");
                                          }
                                        } else {
                                          // isEmailError.value='Enter Email';
                                          // isPassError.value='Enter Password';
                                          showToast("Enter detail");
                                        }
                                        isProcess.value = false;
                                      },
                                      isProcess: isProcess.value,
                                      title: "Sign Up"),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          isSignUp.value = false;
                                        },
                                        child: Text(
                                          'Login',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: res.Responsive.isDesktop(context)
                                ? (60.h)
                                : (40.h)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login as a Admin user',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: getFontColor(context),
                                      fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: (defaultPadding * 2),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 50.h, horizontal: 30.h),
                              decoration: getDefaultDecoration(
                                  bgColor: getBackgroundColor(context),
                                  radius: 10.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
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
                                  ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getCustomTextFiled(
                                            context: context,
                                            isEmailError.value,
                                            textEditingController:
                                                userNameController,
                                            hint: 'Enter your email',
                                            color: getCardColor(context));
                                      },
                                      valueListenable: isEmailError),
                                  const SizedBox(
                                    height: defaultHorPadding,
                                  ),
                                  Text(
                                    'Password',
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
                                  ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getCustomTextFiled(
                                            isPassError.value,
                                            textEditingController:
                                                passwordController,
                                            context: context,
                                            hint: 'Password',
                                            color: getCardColor(context),
                                            iconData: Icons.lock_outline,
                                            isPassword: true);
                                      },
                                      valueListenable: isEmailError),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  LoginButton(
                                      isProcess: isProcess.value,
                                      onChanged: () async {
                                        isProcess.value = true;
                                        if (isNotEmpty(
                                                userNameController.text) &&
                                            isNotEmpty(
                                                passwordController.text)) {
                                          isEmailError.value = '';
                                          isPassError.value = '';
                                          bool isLoginComplete =
                                              await LoginData.login(
                                                  password:
                                                      passwordController.text,
                                                  username:
                                                      userNameController.text);

                                          if (isLoginComplete) {
                                            profileController.getProfileImage();
                                            Get.toNamed(KeyUtil.home);
                                            passwordController.text = '';
                                            userNameController.text = '';
                                          } else {
                                            showToast("Something wrong");
                                          }
                                        } else {
                                          // isEmailError.value='Enter Email';
                                          // isPassError.value='Enter Password';
                                          showToast("Enter detail");
                                        }

                                        isProcess.value = false;
                                      }),

                                  SizedBox(
                                    height: 15.h,
                                  ),

                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection(FirebaseData.adminData)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null &&
                                          snapshot.data!.size > 0) {
                                        return Container();
                                      } else {
                                        if (snapshot.connectionState ==
                                            ConnectionState.active) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Don\'t have an account?',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  isSignUp.value = true;
                                                },
                                                child: Text(
                                                  'Sign Up',
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return Container();
                                      }
                                    },
                                  ),

                                  // StreamBuilder<QuerySnapshot>(
                                  //   stream: FirebaseFirestore.instance.collection(FirebaseData.adminData).snapshots(),
                                  //   builder: (context, snapshot) {
                                  //
                                  //
                                  //     if(snapshot.data!.size > 0){
                                  //       print("snapshot-------${snapshot.data!.size}");
                                  //     }
                                  //
                                  //
                                  //     return Container();
                                  //
                                  //     // if(snapshot.data != null && snapshot.data!.size > 0){
                                  //     //   return Container();
                                  //     //
                                  //     //   // if(snapshot.connectionState == ConnectionState.active){
                                  //     //   //   return Container();
                                  //     //   // }else{
                                  //     //   //   return Container();
                                  //     //   // }
                                  //     //
                                  //     // }else{
                                  //     //   if(snapshot.connectionState == ConnectionState.active){
                                  //     //     return Row(
                                  //     //       mainAxisAlignment: MainAxisAlignment.center,
                                  //     //       crossAxisAlignment: CrossAxisAlignment.center,
                                  //     //       children: [
                                  //     //         Text(
                                  //     //           'Don\'t have an account?',
                                  //     //           textAlign: TextAlign.center,
                                  //     //           style: Theme.of(context)
                                  //     //               .textTheme
                                  //     //               .labelMedium!
                                  //     //               .copyWith(
                                  //     //               color: Colors.grey.shade600,
                                  //     //               fontWeight: FontWeight.w500),
                                  //     //         ),
                                  //     //
                                  //     //         SizedBox(
                                  //     //           width: 5.h,
                                  //     //         ),
                                  //     //         InkWell(
                                  //     //           onTap: (){
                                  //     //             isSignUp.value = true;
                                  //     //           },
                                  //     //           child: Text(
                                  //     //             'Sign Up',
                                  //     //             textAlign: TextAlign.center,
                                  //     //             style: Theme.of(context)
                                  //     //                 .textTheme
                                  //     //                 .labelMedium!
                                  //     //                 .copyWith(
                                  //     //                 color: primaryColor,
                                  //     //                 fontWeight: FontWeight.w600),
                                  //     //           ),
                                  //     //         ),
                                  //     //       ],
                                  //     //     );
                                  //     //   }else{
                                  //     //     return Container();
                                  //     //   }
                                  //     // }
                                  //
                                  //
                                  //   },),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),

                if (res.Responsive.isDesktop(context))
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: getDefaultBackgroundColor(context),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 500,
                      //       width: 500,
                      //       child: Image.asset(
                      //         '${Constants.assetPath}101.png',
                      //         fit: BoxFit.fitHeight,
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ObsController sideMenuController = Get.put(ObsController());
  DataController dataController = Get.put(DataController());

  void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  void onTap(int i) {
    if (i == -1) {
    } else {
      sideMenuController.index(i);
    }
  }

  getTitle(int i) {
    if (i == Constants.dashboardView) {
      return 'Dashboard';
    } else if (i == Constants.categoryView) {
      return 'Category';
    } else if (i == Constants.addCategoryView) {
      return 'Add Category';
    } else if (i == Constants.allQuestion) {
      return 'Question';
    } else if (i == Constants.userView) {
      return 'Users';
    } else if (i == Constants.addQuestionView) {
      return 'Add New Question';
    } else if (i == Constants.editCategory) {
      return 'Update Category';
    } else if (i == Constants.editQuestion) {
      return 'Update Question';
    } else if (i == Constants.testData) {
      return 'Test';
    } else if (i == Constants.testDetail) {
      return 'History';
    } else {
      return '';
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          int i = sideMenuController.index.value;
          if (i == Constants.editCategory) {
            onTap(Constants.categoryView);
          } else if (i == Constants.editQuestion ||
              i == Constants.addQuestionView) {
            onTap(Constants.allQuestion);
          } else if (i == Constants.testData) {
            onTap(Constants.userView);
          } else if (i == Constants.testDetail) {
            onTap(Constants.testData);
          } else if (i > 0) {
            onTap(Constants.dashboardView);
          } else {
            exitApp();
          }
          return false;
        },
        child: Scaffold(
          key: _key, // Assign the key to Scaffold.

          drawer: res.Responsive.isDesktop(context)
              ? null
              : SideMenu(function: (value) {
                  onTap(value);
                  Navigator.pop(context);
                }),
          appBar: AppBar(
            backgroundColor: getBackgroundColor(context),
            // shape: Border(bottom: BorderSide(color: getBorderColor(context), width: 1)),
            // title: getFont(''),
            elevation: 0,
            title: Padding(
              padding: EdgeInsets.only(
                  left: res.Responsive.isDesktop(context) ? 250 : 0),
              child: getFont(
                  getTitle(
                    sideMenuController.index.value,
                  ),
                  style: TextStyle(
                      color: getPrimaryColor(context),
                      fontSize: 0,
                      fontWeight: FontWeight.bold)),
            ),

            leading: res.Responsive.isDesktop(context)
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultHorPadding),
                    child: Row(
                      children: [
                        Image.asset("${Constants.assetIconPath}logo.png",
                            height: 18.h,
                            width: 18.h,
                            color: getFontColor(context)),
                        SizedBox(
                          width: 7.h,
                        ),
                        Expanded(
                          child: getFont('Quiz'.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: getFontColor(context),
                                  fontWeight: FontWeight.w700)),
                          flex: 1,
                        )
                      ],
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.sort_sharp,
                      color: themeController.isDarkTheme
                          ? Colors.white
                          : getPrimaryColor(context),
                    ),
                    onPressed: () => _key.currentState!.openDrawer(),
                  ),
            leadingWidth:
                res.Responsive.isDesktop(context) ? double.infinity : 80.h,

            actions: [
              Visibility(
                visible:
                    sideMenuController.index.value == Constants.dashboardView,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Image.asset(
                      "${Constants.assetDashboardPath}profile.png",
                      height: 25.h,
                      width: 25.h,
                    ),
                  ),
                ),
              ),
              // Visibility(
              //   visible: sideMenuController.index == 1,
              //   child: InkWell(
              //     onTap: () {
              //       PrefData.checkAccess(function: () {
              //         sideMenuController.index == 2;
              //         onTap(Constants.addCategoryView);
              //       });
              //     },
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              //       child: Row(
              //         children: [
              //           getFont('Add New Category',
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontWeight: FontWeight.w500)),
              //           SizedBox(
              //             width: 8,
              //           ),
              //           Icon(
              //             Icons.add_box_rounded,
              //             color: getPrimaryColor(context),
              //             size: 30,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (res.Responsive.isDesktop(context))
                  Expanded(
                    child: SideMenu(function: (value) {
                      onTap(value);
                    }),
                  ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: getDefaultDecoration(
                        radius: 0,
                        bgColor: getDefaultBackgroundColor(context),
                        borderWidth: 1,
                        borderColor: getBorderColor(context)),
                    height: double.infinity,
                    width: double.infinity,
                    child: getTabWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getTabWidget() {
    if (sideMenuController.index.value == Constants.categoryView) {
      return CategoryView(
        dataController: dataController,
        obsController: sideMenuController,
        function: () {
          PrefData.checkAccess(function: () {
            sideMenuController.index.value = 2;
            onTap(Constants.addCategoryView);
          });
        },
      );
    } else if (sideMenuController.index.value == Constants.addCategoryView) {
      return AddCategoryPage(
        obsController: sideMenuController,
      );
    } else if (sideMenuController.index.value == Constants.allQuestion) {
      return TotalQuestionView(
        obsController: sideMenuController,
        dataController: dataController,
      );
      // return AddQuestionPage(sideMenuController);
    } else if (sideMenuController.index.value == Constants.addQuestionView) {
      return AddQuestionPage(sideMenuController);
    } else if (sideMenuController.index.value == Constants.userView) {
      return UserList(dataController: dataController);
    } else if (sideMenuController.index.value == Constants.editCategory) {
      return EditCategoryPage(
        topicModel: sideMenuController.topicModel,
        obsController: sideMenuController,
        dataController: dataController,
      );
    } else if (sideMenuController.index.value == Constants.editQuestion) {
      print("data====${sideMenuController.quizModel!.refId}");
      return EditQuestionPage(
        sideMenuController.quizModel!,
        obsController: sideMenuController,
      );
    } else if (sideMenuController.index.value == Constants.testData) {
      return TestList(dataController: dataController);
    } else if (sideMenuController.index.value == Constants.testDetail) {
      return TestDetail(dataController: dataController);
    } else {
      return DashboardScreen(
        function: (value) {
          onTap(value);
        },
      );
    }
  }
}

// https://www.youtube.com/watch?v=_PZIukxR4bw
