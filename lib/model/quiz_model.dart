

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/model/option_data.dart';

import '../provider/data/FirebaseData.dart';

class QuizModel{
  String? question;
  String? image;
  String? answer="";
  int? answerPosition=-1;
  String? id;
  int? refId;
  int? type;
  int? index;
  List<String>? optionList;

  QuizModel({this.id,this.image,this.question,this.answer,this.optionList,this.refId,this.type,this.index});

  factory QuizModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    int quizType=data['type'];








    List<String> result = [];
    if(quizType==0){
      String list='${data['option_list']}';
      OptionData optionData = OptionData.fromFirestore(jsonDecode(list));
      print("list12===${jsonDecode(list)}");

      result.add(optionData.optionA!);
      result.add(optionData.optionB!);
      result.add(optionData.optionC!);
      result.add(optionData.optionD!);
    }


    return QuizModel(
      id: doc.id,
      question: data['question'],
      answer: data['answer'],
      image: data['image'],
      type: data['type'],
      index: data['index']??0,
      refId: data[FirebaseData.refId],
      optionList: result,
    );
  }
}