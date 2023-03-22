import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/human_controller.dart';

class HumanView extends GetView<HumanController> {
  const HumanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SinglePlayerView'),
          centerTitle: true,
        ),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
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
                            backgroundColor:
                                controller.tictacButtonList[index].bg,
                            disabledBackgroundColor:
                                controller.tictacButtonList[index].bg,
                          ),
                          child: Text(
                            controller.tictacButtonList[index].txt,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.resetGame(context);
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  //resetGame2,
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
