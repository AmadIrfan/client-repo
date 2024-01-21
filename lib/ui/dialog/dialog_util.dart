import 'package:flutter/material.dart';

import 'loading_dialog.dart';

class DialogUtil{
  BuildContext? context;

  bool isOpen = false;

  BuildContext? dialogContext;


  DialogUtil(BuildContext this.context);





  showLoadingDialog(){
    isOpen = true;
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          dialogContext= context;
          return const LoadingDialog();
        }).then((value) => isOpen = false);

  }


  dismissLoadingDialog(){
    if(isOpen){
      isOpen = false;
      Navigator.pop(dialogContext!);
    }
  }



}