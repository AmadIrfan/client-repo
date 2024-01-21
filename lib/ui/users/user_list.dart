import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/provider/data_controller.dart';

import 'package:quizapp/utils/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart' as Nb;

import '../../main.dart';
import '../../model/profile_model.dart';
import '../../provider/data/FirebaseData.dart';
import '../../provider/obs_controller.dart';
import '../../theme/color_scheme.dart';
import '../../utils/pref_data.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';



class UserList extends StatefulWidget {
  final DataController dataController;

  UserList({required this.dataController});

  @override
  _UserList createState() {
    return _UserList(dataController: this.dataController);
  }
}

class _UserList extends State<UserList> {
  final DataController dataController;

  _UserList({required this.dataController});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: Constants.getPaddingForPage() / 2,
        ),
        Container(
          child:  getFont(
            'Users',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: getFontColor(context),
                fontWeight: FontWeight.w700),
          ),
        ),


        Expanded(flex: 1,child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(FirebaseData.loginData)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loaderWidget(context,true);
            }

            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              List<DocumentSnapshot> list = snapshot.data!.docs;

              return list.isNotEmpty
                  ? ListView.builder(
                  itemCount: list.length,

                  padding: EdgeInsets.only(bottom: 15.h),
                  itemBuilder: (context, index) {
                    ProfileModel profileModel =
                    ProfileModel.fromFirestore(list[index]);
                    return Responsive(
                      mobile: ProfileItem(
                        function: () {
                          // dataController.fetchData();
                        },
                        height: _size.width < 650 ? 90 : 110,
                        profileModel: profileModel,
                      ),
                      tablet: ProfileItem(
                        function: () {
                          // dataController.fetchData();
                        },
                        profileModel: profileModel,
                        height: 100,
                      ),
                      desktop: ProfileItem(
                        function: () {
                          // dataController.fetchData();
                        },
                        profileModel: profileModel,
                        height: _size.width < 1400 ? 90 : 120,
                      ),
                    );
                  })
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
        ),)
      ],
    ).marginSymmetric(horizontal: Constants.getPaddingForPage());
    // return (dataController.userList.length > 0)
    //     ? GetBuilder<DataController>(init: DataController(),builder: (dataController) => ListView.builder(
    //   itemCount: dataController.userList.length,
    //   itemBuilder: (context, index) {
    //     TopicModel topicModel =
    //     TopicModel.fromFirestore(dataController.categoryList[index]);
    //     return Responsive(
    //       mobile: ProfileItem(
    //         function: (){dataController.fetchData();},
    //         height: _size.width < 650 ? 100 : 120,
    //         topicModel: topicModel,
    //       ),
    //       tablet: ProfileItem(
    //         function: (){dataController.fetchData();},
    //         topicModel: topicModel,
    //         height:110,
    //       ),
    //       desktop: ProfileItem(
    //         function: (){
    //           dataController.fetchData();
    //         },
    //         topicModel: topicModel,
    //         height: _size.width < 1400 ? 100 : 130,
    //       ),
    //     );
    //   },
    // ),)
    //     : Container();
  }
}

class ProfileItem extends StatelessWidget {
  final double height;
  final ProfileModel profileModel;
  final Function function;

  ProfileItem(
      {required this.height,
      required this.profileModel,
      required this.function});

  @override
  Widget build(BuildContext context) {


    print("list====${profileModel.id}");
    return InkWell(
      onTap: (){
        ObsController sideMenuController = Get.find();
        sideMenuController.setProfileModel(profileModel);
        sideMenuController.index(Constants.testData);
      },
      child: Container(
        // height: height,
        margin: EdgeInsets.only(
            top: getPercentSize(height, 17),
          ),
        padding: EdgeInsets.symmetric(horizontal: getPercentSize(height, 20),vertical: 15.h),
        decoration: getDefaultDecoration(
            radius: getPercentSize(height, 10),
            borderColor: Colors.transparent,
            borderWidth: 1,
            bgColor: getBackgroundColor(context)),
        child: Row(
          children: [

            Image.asset(
              themeController.isDarkTheme?'${Constants.assetDashboardPath}dark_profile.png'
                  :  '${Constants.assetDashboardPath}profile.png',
              height: getPercentSize(height, 50),
              width: getPercentSize(height, 50),
              fit: BoxFit.fill,
            ),



            const SizedBox(width: 25),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getCustomFont(profileModel.firstName!,
                      getPercentSize(height, 18), getFontColor(context), 1,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: getPercentSize(height, 5),
                  ),
                  getCustomFont(profileModel.phoneNumber!,
                      getPercentSize(height, 12),  getFontColor(context), 1,
                      fontWeight: FontWeight.w400)
                ],
              ),
            ),

            InkWell(
              onTap: () {
                print("profileModel===${profileModel.id!}");

                PrefData.checkAccess(function: () {
                  getCommonDialog(
                      context: context
                      ,subTitle: 'User',

                      title: profileModel.active!
                          ? 'Do you want to block this user?'
                          : 'Do you want to active this user?',
                      function: () {
                        FirebaseData.editUser(
                            active: profileModel.active! ? "0" : "1",
                            id: profileModel.id!,
                            function: () {});
                      });
                });
              },
              child: Icon(
                profileModel.active! ? Icons.check_circle : Icons.block,
                color: profileModel.active! ? Colors.green : Colors.red,
                size: getPercentSize(height, 20),
              ),
            ),

            7.width,
            InkWell(
              onTap: () {
                PrefData.checkAccess(function: () {
                  getCommonDialog(
                      context: context,subTitle: 'Delete',
                      title: 'Do you want to delete?',
                      function: () {
                        FirebaseData.deleteUser(
                            id: profileModel.id!, function: () {
                        });
                      });
                });
              },
              child: Image.asset("${Constants.assetIconPath}delete.png",height: getPercentSize(height, 20),color: getIconColor(context),),

              // child: Icon(
              //   Icons.delete,
              //   color: Colors.grey.shade400,
              //   size: getPercentSize(height, 20),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
