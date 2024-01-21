import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/widgets.dart';
import '../dashboard/file_info_card.dart';

class CommonQuizButtonWidget extends StatelessWidget {
  final String optionType;
  final String option;
  final Function? function;
  final bool isSelected;
  final bool isTrue;
  final Color? color;

  CommonQuizButtonWidget(
      {required this.optionType, required this.option, this.function,required this.isSelected,
      this.color,required this.isTrue});

  @override
  Widget build(BuildContext context) {

    double radius = 25.r;

    Color cellColor=(color==null)?isSelected?greenColor:Colors.grey.shade100:color!;

    return InkWell(
      onTap: () {
        if (function != null) {
          function!();
        }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.symmetric(
            horizontal: 15.h,vertical: 10.h),

        decoration:
            getDefaultDecoration(bgColor: cellColor, radius: radius),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: getCustomFont(optionType, 20.sp,
                  isSelected || (color!=null)?Colors.white:  Colors.black, 2,
                  fontWeight: FontWeight.w600, textAlign: TextAlign.center),
            ),
            Center(
              child: getCustomFont(option, 20.sp,
                  isSelected || (color!=null)?Colors.white:  Colors.black, 2,
                  fontWeight: FontWeight.w600, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
