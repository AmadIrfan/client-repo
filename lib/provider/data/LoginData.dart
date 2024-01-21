import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/model/admin_model.dart';
import 'package:quizapp/utils/widgets.dart';
import '../../utils/pref_data.dart';
import 'FirebaseData.dart';

class LoginData {
  static String keyFirstName = 'first_name';
  static String keyLastName = 'last_name';
  static String keyPassword = 'password';
  static String keyUid = '_uid';
  static String keyPhoneNumber = 'phone_number';
  static String keyUserName = 'username';
  // static String keyAdmin = '_admin';




  static Future<bool> login({username, password}) async {

    // bool isRegister = await LoginData
    //     .registerUsingEmailPassword(
    //     email:
    //     username,
    //     password:
    //     password);
    //
    // FirebaseAuth auth = FirebaseAuth.instance;

  bool isRegister = await LoginData
        .loginUsingEmailPassword(
        email:
        username,
        password:
        password);

    FirebaseAuth auth = FirebaseAuth.instance;


    if(isRegister) {
      print("username1212121212===$username === $password=");
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseData.adminData)
          .where(keyUserName, isEqualTo: username)
          .where(keyUid, isEqualTo: auth.currentUser!.uid)
          // .where(keyPassword, isEqualTo: password)
          .get();
      print("username===${querySnapshot.size}");

      if (querySnapshot.size > 0) {
        querySnapshot.docs.forEach((element) {
          AdminModel adminModel = AdminModel.fromFirestore(element);
          print("admin====${element.id}==${auth.currentUser!.email!}");

          // if(auth.currentUser!=null && !auth.currentUser!.email!.contains("demo")){
            PrefData.setLogin(true, element.id, true);
          // }  else {
          //   PrefData.setLogin(true, element.id, false);
          // }
        });
        return true;
      } else {
        return false;
      }
    }else{
      return false;
    }
  }



  static Future<bool> loginUsingEmailPassword({email, password}) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    try {

      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        auth.currentUser!=null;
      });

      return auth.currentUser!=null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {

        if(auth.currentUser != null){
          auth.currentUser != null;
        }

        showToast("The account already exists for that email.");
        return false;
      }
    } catch (e) {

      print("e------------$e");

      return false;

    }
    return false;
  }





  static Future<bool> registerUsingEmailPassword({email, password}) async {


    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        auth.currentUser!=null;
      });

      // user = userCredential.user;
      //
      //
      // user = auth.currentUser;
      // print('The=====${user!.email}');

      return auth.currentUser!=null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {

        if(auth.currentUser != null){
          auth.currentUser != null;
        }

        showToast("The account already exists for that email.");
        return false;
      }
    } catch (e) {
      print("e------------$e");
      return false;
    }

    return false;
  }


}
