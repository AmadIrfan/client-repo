import 'package:flutter/material.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/theme/color_scheme.dart';
import 'package:quizapp/ui/dashboard/file_info_card.dart';
import 'package:quizapp/utils/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizapp/utils/pref_data.dart';

import '../../provider/question_controller.dart';
import '../../utils/widgets.dart';
import '../dashboard/dashboard_screen.dart';
import 'answer_drop_down.dart';
import 'custom_drop_down.dart';
import 'edit_question_view.dart';
import '../../utils/responsive.dart' as res;

class AddQuestionPage extends StatefulWidget {
  final ObsController obsController;

  const AddQuestionPage(this.obsController, {super.key});

  @override
  _AddQuestionPage createState() {
    return _AddQuestionPage(this.obsController);
  }
}

class _AddQuestionPage extends State<AddQuestionPage> {
  final ObsController obsController;

  _AddQuestionPage(this.obsController);

  DataController dataController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    dataController.fetchData();

  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(context,obsController),
      builder: (questionController) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Constants.getPaddingForPage(),vertical: (Constants.getPaddingForPage()/2)),
          decoration: getDefaultDecoration(
              bgColor: getBackgroundColor(context),
              radius: 10.r),
          child: ListView(
            padding: const EdgeInsets.all(defaultHorPadding),
            children: [
              getFont(
                'Question for Quiz',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: getFontColor(context), fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              getTitle('Select Category'),
              CustomDropDown(
                obsController,
                onChanged: (value) {
                  questionController.refId(value);
                },
                value: questionController.refId.value,
              ),
              const SizedBox(
                height: (defaultPadding / 2),
              ),
              getTitle('Question'),
              const SizedBox(
                height: (defaultPadding / 2),
              ),
              ValueListenableBuilder(
                  builder: (context, value, child) {
                    return getAddCustomTextFiled( context,
                        questionController.questionError.value,
                        textEditingController:
                        questionController.questionController,
                        hint: '',
                        iconData: Icons.help_center_outlined,
                        color: getCardColor(context));
                  },
                  valueListenable: questionController.questionError),
              const SizedBox(
                height: (defaultPadding),
              ),

              Row(
                children: [
                  getTitle('Image'),
                  5.width,
                  Expanded(
                    child: getFont(
                      '(optional*)',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: getIconColor(context), fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: (defaultPadding / 2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(


                    child: ValueListenableBuilder(
                        builder: (context, value, child) {
                          return getAddCustomTextFiled( context,
                              questionController.imageError.value,
                              textEditingController:
                              questionController.imageController,
                              hint: '',
                              iconData: Icons.image,
                              color: getCardColor(context));
                        },
                        valueListenable: questionController.imageError),



                    flex: res.Responsive.isDesktop(context) ? 4 : 3,
                  ),
                  12.width,
                  Expanded(
                    child: getBrowseButton(
                        textEditingController:
                        questionController.browseController,
                        function: () {
                          _imgFromGallery(questionController);
                        }),
                    flex: 1,
                  )
                ],
              ),



              const SizedBox(
                height: defaultPadding,
              ),
              SizedBox(
                height: 80.h,
                child: Row(
                  children: [
                    getTitle('Question Type:'),



                    Expanded(
                      child: Obx(() => Row(
                        children: [
                          getOptionButton(context, 'Options', questionController.isOption.value,
                                  () {

                                questionController.changeAnswerType(true);

                              }),
                          getOptionButton(
                              context, 'True/False', !questionController.isOption.value, () {
                            questionController.changeAnswerType(false);

                          }),
                        ],
                      ).marginSymmetric(horizontal: 15)),
                    )
                  ],
                ),

              ),


              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: questionController.isOption.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTitle('Select Option'),
                            const SizedBox(
                              height: (defaultPadding / 2),
                            ),
                            Row(
                              children: [
                                getTitle('A'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(

                                  flex: 1,

                                  child: ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getAddCustomTextFiled( context,
                                            questionController.optionA.value,
                                            textEditingController:
                                            questionController
                                                .optionAController,
                                            hint: 'Option A',
                                            iconData: Icons.border_top_rounded,
                                            color: getCardColor(context));
                                      },
                                      valueListenable:
                                      questionController.optionA),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                getTitle('B'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getAddCustomTextFiled(
                                            context,
                                            questionController.optionB.value,
                                            textEditingController:
                                            questionController
                                                .optionBController,
                                            hint: 'Option B',
                                            iconData: Icons.border_top_rounded,
                                            color: getCardColor(context));
                                      },
                                      valueListenable:
                                      questionController.optionB),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: defaultPadding,
                            ),
                            Row(
                              children: [
                                getTitle('C'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getAddCustomTextFiled( context,
                                            questionController.optionC.value,
                                            textEditingController:
                                            questionController
                                                .optionCController,
                                            hint: 'Option C',
                                            iconData: Icons.border_top_rounded,
                                            color: getCardColor(context));
                                      },
                                      valueListenable:
                                      questionController.optionC),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                getTitle('D'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return getAddCustomTextFiled(context,
                                            questionController.optionD.value,
                                            textEditingController:
                                            questionController
                                                .optionDController,
                                            hint: 'Option D',
                                            iconData: Icons.border_top_rounded,
                                            color: getCardColor(context));
                                      },
                                      valueListenable:
                                      questionController.optionD),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: defaultPadding,
                            ),
                          ],
                        )),
                    getTitle('Select Correct Answer'),
                    AnswerDropDown(obsController,
                        list: questionController.isOption.value ? optionList : trueFalseOptionList,
                        onChanged: (value) {
                          questionController.optionType(value);
                        },value: questionController.optionType.value),
                  ],
                );
              }),

              const SizedBox(
                height: (defaultPadding / 2),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getDefaultButton(context, 'Add New Question', () async {
                    PrefData.checkAccess(function: () async {
                      bool isValidation = false;
                      bool isUrl = false;

                      if (isNotEmpty(questionController.imageController.text)) {
                        bool validURL =
                            Uri.parse(questionController.imageController.text)
                                .isAbsolute;
                        String url = '';
                        if (validURL) {
                          questionController.isLoading(true);
                          url = questionController.imageController.text;
                          isUrl = true;
                          isValidation = questionController.validation();
                        } else {
                          if (_image == null) {
                            questionController.imageError.value = 'Enter valid url';
                          } else {
                            questionController.imageError.value = '';
                            isValidation = questionController.validation();
                          }
                        }

                        if (isValidation) {
                          questionController.isLoading(true);
                          if (!isUrl) {
                            url = await questionController.uploadFile(_image!);
                          }

                          questionController.addQuestion(
                              url, obsController);
                        }
                      } else {
                        questionController.addQuestion('', obsController);
                      }
                    });
                  })
                ],
              ),

              Obx(() {
                return loaderWidget(context,questionController.isLoading.value);
              }),
            ],
          ),
        );
      },
    );
  }

  XFile? _image;
  final picker = ImagePicker();

  _imgFromGallery(QuestionController questionController) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    _image = image;

    if(_image!=null) {
      questionController.imageController.text = _image!.name;
      questionController.imageError.value = '';
    }
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

getOptionButton(
    BuildContext context, String title, bool value, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Row(
        children: [
          Icon(
            value ? Icons.radio_button_checked : Icons.radio_button_off,
            color: value ? primaryColor : getIconColor(context),
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          getFont(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: getFontColor(context), fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
