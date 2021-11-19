import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/Core/utils/Screen_hight.dart';
import 'package:todo_app/App/presentation/HomePageView/Home_Controller.dart';

class SwipperCard extends StatelessWidget {
  const SwipperCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.12),
        GetBuilder<HomeController>(
          builder: (controller) {
            return controller.notesModel.isEmpty
                ? Container()
                : Swiper(
                    itemCount: controller.notesModel.length,
                    itemWidth: screenWidth * 0.70,
                    itemHeight: screenHeight * 0.35,
                    layout: SwiperLayout.STACK,
                    itemBuilder: (context, index) {
                      return FocusedMenuHolder(
                        onPressed: () {},
                        menuWidth: screenWidth * 0.70,
                        menuItemExtent: 50,
                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(
                            title: Text("EDIT"),
                            onPressed: () {
                              controller.displaybottomSheet(
                                headerName: "Edit Notes",
                                buttonName: "Update Notes",
                                titleText: controller.notesModel[index].title,
                                descriptionText:
                                    controller.notesModel[index].description,
                                index: controller.notesModel[index].id,
                              );
                            },
                            trailingIcon: Icon(Icons.edit),
                          ),
                          FocusedMenuItem(
                            title: Text("DELETE"),
                            onPressed: () {
                              controller.deleteNotes(
                                  index: controller.notesModel[index].id!);
                            },
                            trailingIcon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                        child: Container(
                          height: screenHeight * 0.35,
                          decoration: BoxDecoration(
                            color: controller.notesModel[index].color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Container()),
                                    Text(
                                      controller.notesModel[index].time
                                          .toString()
                                          .substring(0, 11),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Title : ${controller.notesModel[index].title}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "${controller.notesModel[index].description}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}
