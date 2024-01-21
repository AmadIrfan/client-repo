
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:quizapp/provider/data/FirebaseData.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/utils/Constants.dart';

import 'package:nb_utils/nb_utils.dart' as nb;

import '../../theme/color_scheme.dart';
import '../../utils/pref_data.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';



class CategoryView extends StatefulWidget {
  final DataController dataController;
  final ObsController obsController;
  final Function function;

  const CategoryView({super.key, required this.dataController,required this.obsController,required this.function});

  @override
  _CategoryView createState() {
    return _CategoryView(dataController: this.dataController);
  }
}

class _CategoryView extends State<CategoryView> {
  final DataController dataController;

  _CategoryView({required this.dataController});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;


    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1,child:  getFont(
              'Category',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: getFontColor(context), fontWeight: FontWeight.w700),
            ),),

            getDefaultButton(context, 'Create', () async {
              widget.function();
            },)
          ],
        ),

        Expanded(child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(FirebaseData.topicList)
              .snapshots(),
          builder: (context, snapshot) {

            print("state===${snapshot.connectionState}");

            if(snapshot.connectionState == ConnectionState.waiting){
              return loaderWidget(context,true);
            }
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              List<DocumentSnapshot> list = snapshot.data!.docs;

              return list.isNotEmpty
                  ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  TopicModel topicModel = TopicModel.fromFirestore(
                      list[index]);
                  return Responsive(
                    mobile: ListItem(
                      obsController: widget.obsController,
                      index: index,
                      function: () {
                        dataController.fetchData();
                        // dataController.fetchData();
                      },
                      height: _size.width < 650 ? 50 : 70,
                      topicModel: topicModel,
                    ),
                    tablet: ListItem(
                      obsController: widget.obsController,
                      index: index,
                      function: () {
                        dataController.fetchData();
                        // dataController.fetchData();
                      },
                      topicModel: topicModel,
                      height: 60,
                    ),
                    desktop: ListItem(
                      obsController: widget.obsController,
                      index: index,
                      function: () {
                        dataController.fetchData();
                        // dataController.fetchData();
                      },
                      topicModel: topicModel,
                      height: _size.width < 1400 ? 50 : 70,
                    ),
                  );
                },
              )
                  : Center(
                child: getFont(
                  'No data',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: getFontColor(context), fontWeight: FontWeight.w600),
                ),
              );
            } else {
              return Container();
            }
          },
        ))
      ],
    ).paddingSymmetric(horizontal: Constants.getPaddingForPage(),vertical: Constants.getPaddingForPage()/2);
  }
}

class ListItem extends StatelessWidget {
  final double height;
  final TopicModel topicModel;
  final int index;
  final Function function;
  final ObsController obsController;

  const ListItem(
      {super.key, required this.obsController,required this.index,required this.height, required this.topicModel, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(KeyUtil.quizList, arguments: topicModel);
      },
      child: Container(
        height: height,

        margin: EdgeInsets.symmetric(
            vertical: getPercentSize(height, 20),
            ),
        padding: EdgeInsets.symmetric(horizontal: getPercentSize(height, 20)),


        decoration: getDefaultDecoration(

            radius: getPercentSize(height, 15),
            borderColor: Colors.transparent,
            borderWidth: 0,
            bgColor: getBackgroundColor(context)),

        child: Row(
          children: [


            getFont('${(index+1)}.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getPercentSize(height, 25),
                )),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: getFont(topicModel.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: getFontColor(context),
                    fontSize: getPercentSize(height, 25),
                  )),
            ),
            InkWell(
              onTap: ()  {
                 PrefData.checkAccess(function: (){
                   obsController.index(Constants.editCategory);
                   obsController.setTopicModel(topicModel);
                 });
              },
              child: Image.asset("${Constants.assetIconPath}edit.png",height: getPercentSize(height, 35),color: getIconColor(context),),
              // child: Icon(
              //   Icons.edit,
              //   color: Colors.black,
              //   size: getPercentSize(height, 35),
              // ),
            ),
            15.width,
            InkWell(
              onTap: () {
                PrefData.checkAccess(function: (){
                  getCommonDialog(context: context, title: 'Do you want to delete?',subTitle: 'Delete', function: (){
                    FirebaseData.deleteCategory(
                        id: topicModel.id!,
                        refId: topicModel.refId!,
                        function: () {
                          print("cva==true");
                          function();
                        });
                  });
                });
              },
              child: Image.asset("${Constants.assetIconPath}delete.png",height: getPercentSize(height, 35),color: getIconColor(context),),
              // child: Icon(
              //   Icons.delete,
              //   color: primaryColor,
              //   size: getPercentSize(height, 35),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
