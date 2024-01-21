import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../utils/widgets.dart';



class LoginTextFiled extends StatelessWidget {
  final Function? onChanged;
  final String? hint;
  final bool? isEnabled;
  final bool? isNumber;
  final bool? isPassword;
  final IconData iconData;
  final bool? isMargin;
  final TextEditingController textEditingController;

  LoginTextFiled({
    Key? key,
     this.onChanged,
       this.hint,
       this.isNumber,
       this.isMargin,
       this.isPassword,
       this.isEnabled,
    required this.iconData,
  required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile:getReturnWidget(  size.width < 650 ? 45 : 65,) ,
      tablet:getReturnWidget(55) ,
      desktop:getReturnWidget( size.width < 1400 ?  45 : 55) ,
    );
  }

  getReturnWidget(double height){
    return  getTextWidget(
      hint:hint!,
      iconData: iconData,
      onChange: (value){
        if(onChanged!=null) {
          onChanged!(value);
        }
      },
      isPassword: isPassword,
      dataController: textEditingController,
      isEnabled: isEnabled,
      height: height,
    );
  }
}




