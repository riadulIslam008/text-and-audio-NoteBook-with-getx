import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:todo_app/MyApp/Controller/HomeController.dart';
import 'package:todo_app/MyApp/utils/UniversalVeriable.dart';

class SwipperCard extends StatelessWidget {
  const SwipperCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.12),
        GetBuilder<HomeController>(
          init: HomeController(),
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
                                titleText: controller.notesModel[index].titile,
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
                                  index: controller.notesModel[index].id);
                            },
                            trailingIcon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.notesModel[index].color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //color: Colors.primaries
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                                    style: dateStyle,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Title : ${controller.notesModel[index].titile}",
                                style: titleStyle,
                              ),
                              SizedBox(height: 20),
                              Expanded(
                                child: Text(
                                  "${controller.notesModel[index].description}",
                                  overflow: TextOverflow.ellipsis,
                                  style: descriptionStyle,
                                ),
                              ),
                            ],
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
