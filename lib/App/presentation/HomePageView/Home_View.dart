import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/App/Core/utils/Screen_hight.dart';
import 'package:todo_app/App/Core/widgets/About_Dialog_Box.dart';
import 'package:todo_app/App/presentation/HomePageView/widget/AudioNotes.dart';
import 'package:todo_app/App/presentation/HomePageView/widget/Floating_Action_Button.dart';
import 'package:todo_app/App/presentation/HomePageView/widget/SwiperCard.dart';
import 'package:todo_app/App/Core/utils/Colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight * 0.35,
                width: screenWidth,
                color: indigoColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notes",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          IconButton(
                            onPressed: () {
                              aboutDialogBox(
                                  description:
                                      "This App made for only education purpose.");
                            },
                            icon: Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AudioNotes(),
            ],
          ),
          SwipperCard(),
        ],
      ),
    );
  }
}
