import 'package:quizapp/provider/data/FirebaseData.dart';
class CategoryData{


  int? refId;
  String? name;
  String? date;





  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = name;
    data[FirebaseData.refId] = refId;
    data['date'] = DateTime.now();
    return data;
  }

}