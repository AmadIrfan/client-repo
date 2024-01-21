import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/provider/data/FirebaseData.dart';
class QuestionData{

  String? answer;

  String? optionList;
  String? image;
  int? refId;
  int? type;
  int? index;
  String? question;
  // Timestamp? timestamp;





  Map<String, dynamic> toJson(bool isAdd) {
    var timestamp = Timestamp.now();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['image'] = this.image;
    data['option_list'] = this.optionList;
    data['question'] = this.question;
    data['type'] = this.type;
    data['index'] = this.index;

    //
    // if(isAdd){
    //   data['timeStamp'] = timestamp;
    // }
    //

    data[FirebaseData.refId] = this.refId;
    return data;
  }

}