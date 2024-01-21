import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/utils/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String pkgName = "web_quiz";
  static String login = "${pkgName}login";
  static String userId = "${pkgName}userId";
  static String keyIsAccess = "${pkgName}isAccess";



  static setLogin(bool s,String id,bool isAccess) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(login, s);
    prefs.setString(userId, id);
    prefs.setBool(keyIsAccess, isAccess);

    if(!s){
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signOut();
    }
  }


  static Future  checkAccess({required Function function}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAccess= prefs.getBool(keyIsAccess) ?? false;
    if(isAccess){
      function();
    }else{
      showToast("You are demo user..");
    }
  }


  static getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId) ?? '';
  }

  static getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(login) ?? false;
  }


}
