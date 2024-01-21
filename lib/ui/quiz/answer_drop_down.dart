


import 'package:flutter/material.dart';
import 'package:quizapp/theme/color_scheme.dart';
import 'package:get/get.dart';

import '../../provider/obs_controller.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';

class AnswerDropDown extends StatelessWidget {

  final List<String> list;
  final Function? onChanged;
  final String? value;
  final  ObsController obsController;



  AnswerDropDown(this.obsController,{
    Key? key,
    this.onChanged,
    this.value,

  required  this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;


    return Obx((){
      return  Responsive(
        mobile: getDropDown(

          context: context,
          height: _size.width < 650 ? 50 : 70,
        ),
        tablet: getDropDown(

          context: context,

          height:  60,
        ),
        desktop:getDropDown(

          context: context,
          height: _size.width < 1400 ? 50 : 60,
        ),
      );
    });
  }
  getDropDown(
      {required double height,required BuildContext context}) {

    return      Container(
      height: height,

      margin: EdgeInsets.symmetric(vertical: getPercentSize(height,20)),
        padding: EdgeInsets.symmetric(horizontal: getPercentSize(height,25)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.transparent,width: 1),
            color: getCardColor(context)

        ),


      alignment: Alignment.centerLeft,
      child:
      list.isNotEmpty? DropdownButton(
        hint: getFont('Select Correct Answer'),
        isExpanded: true,
        items: list.map((val) {

          return DropdownMenuItem(
            value: val,
            child: getFont(val),
          );
        }).toList(),
        value: obsController.answerValue.value,
        underline: Container(),
        onChanged: (value) {



          obsController.answerValue(value as String);

          onChanged!(value);

        },
      ):
      getFont('Select Correct Answer')

    );
  }
}


