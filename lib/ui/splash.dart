import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/utils/app_routes.dart';
import 'package:get/get.dart';

import '../utils/Constants.dart';
import '../utils/pref_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkData();
  }

  checkData() async {
    bool isLogin = await PrefData.getLogin();

    Future.delayed(const Duration(seconds: 3), () {
      if (isLogin) {
        Get.toNamed(KeyUtil.home);
      }else{
        Get.toNamed(KeyUtil.loginPage);
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset("${Constants.assetPath}logo.png",
            height: 120, width: 120));
  }
}
