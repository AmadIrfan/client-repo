import 'package:flutter/material.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/theme/color_scheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../provider/category_controller.dart';
import '../../utils/Constants.dart';
import '../../utils/widgets.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/file_info_card.dart';

class AddCategoryPage extends StatefulWidget {
  final ObsController? obsController;
  final TopicModel? topicModel;

  const AddCategoryPage({super.key, this.obsController, this.topicModel});

  @override
  _AddCategoryPage createState() {
    return _AddCategoryPage(this.obsController!);
  }
}

class _AddCategoryPage extends State<AddCategoryPage> {
  final ObsController obsController;

  _AddCategoryPage(this.obsController);

  @override
  Widget build(BuildContext context) {
    return widget.topicModel == null
        ? getCommonWidget()
        : WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,

                title: getFont('Edit'),
              ),
              body: getCommonWidget(),
            ),
            onWillPop: () async {
              Navigator.of(context).pop();
              return true;
            });
  }

  getCommonWidget() {
    return GetBuilder<CategoryController>(
      init: CategoryController(topicModel: widget.topicModel),
      builder: (categoryController) {
        return Container(

          margin: EdgeInsets.symmetric(
              horizontal: Constants.getPaddingForPage(),
              vertical: (Constants.getPaddingForPage() / 2)),
          decoration: getDefaultDecoration(
              bgColor: getBackgroundColor(context), radius: 10.r),


          child: ListView(
            padding: const EdgeInsets.all(defaultHorPadding),
            children: [
              getFont(
                'Create Category',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: getFontColor(context), fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              getTitle('Category Name'),

              const SizedBox(
                height: (defaultPadding/2),
              ),

              getAddCustomTextFiled(context,'',textEditingController: categoryController.nameController,
                  hint: 'Enter here..', iconData: Icons.category,color: getCardColor(context))
              ,
              const SizedBox(
                height: defaultPadding,
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  getDefaultButton(context, 'Add New Category', (){
                    if( widget.topicModel == null) {
                      categoryController.addCategory(obsController,);
                    }else{
                      categoryController.updateCategory(obsController);
                    }
                  })
                ],
              ),

              Obx((){
                return loaderWidget(context,categoryController.isLoading.value);
              }),

            ],
          ),
        );
      },
    );
  }




  getTitle(String s) {
    return getFont(
      s,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: getFontColor(context), fontWeight: FontWeight.w600),
    );
  }
}
