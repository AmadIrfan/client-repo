


import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String? username;
  String? image;
  String? id;
  // bool isAdmin= false;


  AdminModel({this.username,this.image,this.id});
  // AdminModel({this.username,this.image,this.id,required this.isAdmin});

  factory AdminModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    print("dat===$data");

    return AdminModel(

      username: (data['username']==null)?"":data['username'],
      image: (data['image']==null)?"":data['image'],
      // isAdmin: (data['is_admin']==null)?"":data['is_admin'],
      id:doc.id,
    );
  }

}
