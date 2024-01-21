import 'package:flutter/material.dart';
import 'package:quizapp/ui/dashboard/file_info_card.dart';

import '../../utils/Constants.dart';
import '../../utils/widgets.dart';


class LoadingDialog extends StatefulWidget {
  final Function? func;

  const LoadingDialog({Key? key, this.func}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return
      Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child:
      contentBox(context)
    ,
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getHeightPercentSize(context, 3),
      horizontal: getWidthPercentSize(context, 5)),
      child: Row(
        children: [
          Image.asset(
            '${Constants.assetPath}gif_3.gif',
            color: primaryColor,
            height: getWidthPercentSize(context, 10),
            width: getWidthPercentSize(context, 10),
          ),
          SizedBox(
            width: getWidthPercentSize(context, 3),
          ),

          getFont(
            'Please wait....',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getHeightPercentSize(context, 2.2)
            )
          )

        ],
      ),
    );
  }
}
