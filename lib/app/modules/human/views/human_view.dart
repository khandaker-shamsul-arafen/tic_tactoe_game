//import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/human_controller.dart';
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
