import 'package:flutter/material.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:get/get.dart';

import '../../utils/responsive.dart';
import '../../utils/Constants.dart';
import '../../utils/widgets.dart';
import 'dashboard_screen.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Color primaryColor = "#389B61".toColor();
Color defaultBgColor = "#FFFFFF".toColor();
Color borderColor = "#DEE7FE".toColor();
Color fontColor = "#333333".toColor();
Color bgColor1 = "#FBEEDA".toColor();
Color bgColor2 = "#E1F9EB".toColor();
Color bgColor3 = "#FFEAEA".toColor();
Color color1 = "#FF9B00".toColor();
Color color2 = "#389B61".toColor();
Color color3 = "#FF7777".toColor();
Color greenColor = "#43C577".toColor();
Color skipColor = "#FFDF39".toColor();
Color redColor = "#E53A35".toColor();
const secondaryColor = Color(0xFF2A2D3E);
Color bgColor = "#F4F4F4".toColor();
// Color bgColor = "#FAFAFA".toColor();
// Color bgColor = "#F7F9FF".toColor();

List<String> stringList = [
  'Total Categories',
  'Total Questions',
  'Total Users'
];

class FileInfoCard extends StatelessWidget {
  final DataController dataController = Get.put(DataController());

  FileInfoCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Responsive(
              mobile: getFont(
                stringList[index],
                overflow: TextOverflow.ellipsis,
                style: size.width < 650
                    ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                  fontSize: 20 )
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white, ),
                maxLines: 1,
              ),
              tablet: getFont(
                stringList[index],
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
                maxLines: 1,
              ),
              desktop: getFont(
                stringList[index],
                overflow: TextOverflow.ellipsis,
                style: size.width < 1400
                    ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,)
                    : Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,),
                maxLines: 1,
              )),


          const SizedBox(
            height: defaultPadding,
          ),

          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GetBuilder<DataController>(
                    builder: (sController) {
                      int total = 0;
                      if (index == 0) {
                        total = sController.categoryList.length;
                      } else if (index == 1) {
                        total = sController.quizList.length;
                      } else {
                        total = sController.userList.length;
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: getFont(
                              '$total',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.white,
                                    height: 0.5,
                                  ),
                            ),
                          ),
                          Responsive(
                            mobile: getIconWidget(
                              size.width < 650 ? 25 : 30,
                            ),
                            tablet: getIconWidget(
                              40,
                            ),
                            desktop: getIconWidget(
                              size.width < 1400 ? 30 : 40,
                            ),
                          ),
                        ],
                      );
                    },
                  )

                  ),


            ],
          ),


        ],
      ),
    );
  }

  getIconWidget(double size) {
    return Image.asset(
      '${Constants.assetPath}growth-graph.png',
      color: Colors.white,
      height: size,
      width: size,
    );
  }
}
