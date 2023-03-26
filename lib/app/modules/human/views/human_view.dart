//import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/human_controller.dart';

// class HumanView extends GetView<HumanController> {
//   const HumanView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Play  With  Human'),
//           centerTitle: true,
//         ),
//         // body: Obx(() {
//         //   return Padding(
//         //     padding: const EdgeInsets.all(20.0),
//         //     child: Column(
//         //       children: [
//         //         SizedBox(
//         //           width: 500,
//         //           height: 500,
//         //           child: GridView.builder(
//         //             itemCount: controller.tictacButtonList.length,
//         //             gridDelegate:
//         //                 const SliverGridDelegateWithFixedCrossAxisCount(
//         //                     crossAxisCount: 3,
//         //                     mainAxisSpacing: 10,
//         //                     crossAxisSpacing: 10,
//         //                     childAspectRatio: 1),
//         //             itemBuilder: (BuildContext context, int index) {
//         //               debugPrint("${controller.tictacButtonList[index]}");
//         //               return SizedBox(
//         //                 height: 100,
//         //                 width: 100,
//         //                 child: ElevatedButton(
//         //                   onPressed: () {
//         //                     // controller.tictacButtonList[index].enable
//         //                     //     ? controller.startGame(index, context)
//         //                     //     : null;
//         //                   },
//         //                   style: ElevatedButton.styleFrom(
//         //                     shape: RoundedRectangleBorder(
//         //                         borderRadius: BorderRadius.circular(10.0)),
//         //                     backgroundColor:
//         //                         controller.tictacButtonList[index].bg,
//         //                     disabledBackgroundColor:
//         //                         controller.tictacButtonList[index].bg,
//         //                   ),
//         //                   child: Text(
//         //                     controller.tictacButtonList[index].txt,
//         //                     style: const TextStyle(
//         //                         color: Colors.white, fontSize: 40),
//         //                   ),
//         //                 ),
//         //               );
//         //             },
//         //           ),
//         //         ),
//         //         Row(
//         //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //           children: [
//         //             ElevatedButton(
//         //               onPressed: () {
//         //                // controller.resetGame(context);
//         //               },
//         //               style:
//         //                   ElevatedButton.styleFrom(foregroundColor: Colors.red),
//         //               //resetGame2,
//         //               child: const Text(
//         //                 "Reset",
//         //                 style: TextStyle(color: Colors.white, fontSize: 20),
//         //               ),
//         //             ),
//         //             ElevatedButton(
//         //               onPressed: () {
//         //                 controller.modeChange(context);
//         //               },
//         //               style:
//         //                   ElevatedButton.styleFrom(foregroundColor: Colors.red),
//         //               //resetGame2,
//         //               child: const Text(
//         //                 "Mood",
//         //                 style: TextStyle(color: Colors.white, fontSize: 20),
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ],
//         //     ),
//         //   );
//         // }));
//
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamePage extends StatelessWidget {
  final HumanController gameController = Get.put(HumanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TicTacToe Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game ID: ${gameController.gameId}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Obx(() => GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => gameController.makeMove(index),
                  child: Text(
                    gameController.gameBoard[index],
                    style: TextStyle(fontSize: 48),
                  ),
                );
              },
            )),
            SizedBox(height: 16),
            Obx(() {
              if (gameController.winner.value != '') {
                return Text(
                  '${gameController.winner.value} wins!',
                  style: TextStyle(fontSize: 24),
                );
              } else if (gameController.gameBoard.contains('')) {
                return Text(
                  'Current player: ${gameController.currentPlayer.value}',
                  style: TextStyle(fontSize: 24),
                );
              } else {
                return Text(
                  'Draw!',
                  style: TextStyle(fontSize: 24),
                );
              }
            }),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => gameController.createGame(),
              child: Text('Create Game'),
            ),
            SizedBox(height: 8),
            Obx(() {
              if (gameController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () => gameController.joinGame(gameController.gameId.value),
                  child: Text('Join Game'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
