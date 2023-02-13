import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/single_player_controller.dart';

class SinglePlayerView extends GetView<SinglePlayerController> {
  const SinglePlayerView({Key? key}) : super(key: key);

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
                            mainAxisSpacing: 7,
                            crossAxisSpacing: 7,
                            childAspectRatio: 1),
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint("${controller.tictacButtonList[index]}");
                      return SizedBox(
                        height: 100,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.tictacButtonList[index].enable
                                ? controller.startGame(index)
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
                )
              ],
            ),
          );
        }));
  }
}
