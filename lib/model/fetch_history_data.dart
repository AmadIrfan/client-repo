
import 'package:quizapp/provider/data/FirebaseData.dart';

import 'history_model.dart';

class FetchHistoryData{


  String? dataList;
  List<HistoryModel>? list;


  FetchHistoryData({this.dataList, this.list});

  factory FetchHistoryData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson[FirebaseData.detailList] as List;



    return FetchHistoryData(
        list: list.map((i) {

          return HistoryModel.fromJson(i);
        }).toList()
    );
  }




}