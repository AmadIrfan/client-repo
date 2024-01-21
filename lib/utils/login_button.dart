import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/responsive.dart';
import '../../utils/widgets.dart';
import '../ui/dashboard/file_info_card.dart';

class LoginButton extends StatelessWidget {
  final Function onChanged;
  final String? title;
  final bool? isProcess;

  LoginButton({
    Key? key,
    required this.onChanged,
     this.isProcess,
     this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Responsive(
      mobile:getReturnWidget(  context,_size.width < 650 ?45 : 65,) ,
      tablet:getReturnWidget(context,  55) ,
      desktop:getReturnWidget( context,_size.width < 1400 ?  45 : 55),
    );
  }

  getReturnWidget(BuildContext context,double height) {
    return InkWell(
      onTap: () {
        onChanged();
      },
      child: Container(
          // margin: EdgeInsets.symmetric(
          //     vertical:  getPercentSize(height, 20) ),
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: primaryColor,
          ),

          child: Center(
              child:isProcess!=null && isProcess! ?getProgressDialog(context,color1: Colors.white):getFont(title == null  ? 'Login': title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: getPercentSize(height, 35))))),
    );
  }
}
