import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/human_controller.dart';

class HumanView extends GetView<HumanController> {
  const HumanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Play  With  Human'),
          centerTitle: true,
        ),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: 500,
                  height: 500,
                  child: GridView.builder(
                    itemCount: controller.tictacButtonList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1),
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint("${controller.tictacButtonList[index]}");
                      return SizedBox(
                        height: 100,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.tictacButtonList[index].enable
                                ? controller.startGame(index, context)
                                : null;
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor:
                                controller.tictacButtonList[index].bg,
                            disabledBackgroundColor:
                                controller.tictacButtonList[index].bg,
                          ),
                          child: Text(
                            controller.tictacButtonList[index].txt,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.resetGame(context);
                      },
                      style:
                          ElevatedButton.styleFrom(foregroundColor: Colors.red),
                      //resetGame2,
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.modeChange(context);
                      },
                      style:
                          ElevatedButton.styleFrom(foregroundColor: Colors.red),
                      //resetGame2,
                      child: const Text(
                        "Mood",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
