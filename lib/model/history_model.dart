

import 'package:quizapp/model/option_data.dart';
int quizTime = 300;
int skipped = 1;
int trueFalse = 1;
int correct = 2;
int wrongType = 3;

class HistoryModel{
  String? question;
  String? image;
  String? answer="";
  String? selectedAnswer="";
  String? optionList="";
  OptionData? optionData;
  int? type=skipped;
  int? quizType=0;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\"question\"'] = '\"${this.question}\"';
    data['\"image\"'] = '\"${this.image}\"';
    data['\"answer\"'] = '\"${this.answer}\"';
    data['\"type\"'] = '\"${this.type}\"';
    data['\"selectedAnswer\"'] = '\"${this.selectedAnswer}\"';
    data['\"quizType\"'] = '${this.quizType}';
    data['\"optionList\"'] = this.optionList==null?'\"\"':this.optionList;
    return data;
  }




  factory HistoryModel.fromJson(Map<String, dynamic> data) {
    return HistoryModel(
      question: data["question"],
      image: data["image"],
      answer: data["answer"],
      type: (data["type"]==null)?skipped:int.parse(data["type"]),
      selectedAnswer: data["selectedAnswer"],
      optionData:(data["optionList"].isEmpty)?null:OptionData.fromFirestore(new Map<String, dynamic>.from(data['optionList'])),
      quizType: data["quizType"],
    );
  }


  HistoryModel({
    this.image,
    this.question,
    this.type,
    this.answer,
    this.selectedAnswer,
    this.optionList,
    this.quizType,
    this.optionData,
  });



}