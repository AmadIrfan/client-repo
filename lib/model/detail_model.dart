


import 'package:cloud_firestore/cloud_firestore.dart';



class DetailModel{

  String? date="";
  int? refId=1;
  String? list;

  int? id=1;
  int? right=0;
  int? totalQuestion=0;
  int? skip=0;
  int? time=0;
  int? wrong=0;





  factory DetailModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    return DetailModel(
      date: data['date'],
      right: data['right'],
      list: data['list'],
      refId: data['ref_id'],
      skip: data['skip'],
      wrong: data['wrong'],
      time: data['time'],
      totalQuestion: data['totalQuestion'],
    );
  }


  DetailModel({this.date,this.list,this.refId,this.right,this.skip,this.wrong,this.time,this.totalQuestion});



}