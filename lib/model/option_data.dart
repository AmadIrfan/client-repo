class OptionData{


  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;




  OptionData({this.optionA,this.optionB,this.optionC,this.optionD});




  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['optionA'] = this.optionA;
  data['optionB'] = this.optionB;
  data['optionC'] = this.optionC;
  data['optionD'] = this.optionD;
  return data;
  }

 factory OptionData.fromFirestore(Map data) {
    return OptionData(
      optionA: data['optionA'],
      optionB: data['optionB'],
      optionC: data['optionC'],
      optionD: data['optionD'],
    );
  }



}