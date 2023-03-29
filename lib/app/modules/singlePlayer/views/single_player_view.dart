import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/single_player_controller.dart';

class SinglePlayerView extends GetView<SinglePlayerController> {
  const SinglePlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Play  With  Computer '),
          centerTitle: true,
        ),
        body: ConnectionNotifierToggler(
            onConnectionStatusChanged: (connected) {
              /// that means it is still in the initialization phase.
              if (connected == null) return;
            },
            connected: Column(
              children: [
                SizedBox(
                  height: 500,
                  width: 500,
                  child: Obx(() {
                    return GridView.builder(
                      // use GridView to display the game board
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1),
                      itemCount: controller.board?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.makeMove(index, context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.board?[index] == 'O'
                                  ? Colors.blue
                                  : controller.board?[index] == 'X'
                                      ? Colors.red
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              controller.board?[index] ?? "",
                              style: TextStyle(
                                fontSize: 40,
                                color: controller.board?[index] == 'X' ||
                                        controller.board?[index] == 'O'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
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
            disconnected: const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                "Please check your internet connection.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              ),
            )));
  }
}
