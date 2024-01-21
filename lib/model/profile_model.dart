

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? lastName;
  String? firstName;
  String? phoneNumber;
  // String? password;
  bool? active;
  String? image;
  String? id;


  ProfileModel({this.id,this.phoneNumber,this.lastName,this.firstName,
    // this.password,
  this.active,this.image});

  factory ProfileModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    return ProfileModel(
      lastName: data['last_name'],
      firstName: data['first_name'],
      phoneNumber: data['phone_number'],
      // password: data['password'],
      active: (data['active']==null)?true:(data['active']=="1")?true:false,
      image: (data['image']==null)?"":data['image'],
      id:doc.id,
    );
  }

}
