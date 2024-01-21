import 'package:flutter/material.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../provider/category_controller.dart';
import '../../theme/color_scheme.dart';
import '../../utils/Constants.dart';
import '../../utils/widgets.dart';
import '../dashboard/dashboard_screen.dart';

class EditCategoryPage extends StatefulWidget {
  final TopicModel? topicModel;
  final ObsController obsController;
  final DataController dataController;

  const EditCategoryPage({super.key,  this.topicModel,required this.obsController,required this.dataController});

  @override
  _EditCategoryPage createState() {
    return _EditCategoryPage();
  }
}

class _EditCategoryPage extends State<EditCategoryPage> {


  @override
  Widget build(BuildContext context) {
    return getCommonWidget();
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
                'Update Category',
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
                  hint: 'Enter here..', iconData: Icons.category,color: getCardColor(context)),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getDefaultButton(context, 'Update Category', (){
                    categoryController.updateCategory(widget.obsController);
                    widget.dataController.fetchData();
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
