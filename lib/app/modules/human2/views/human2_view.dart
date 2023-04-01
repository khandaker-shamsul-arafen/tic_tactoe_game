import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/human2_controller.dart';

class Human2View extends GetView<Human2Controller> {
  const Human2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.joinGame('game1', 'user1');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Human2View'),
        centerTitle: true,
      ),
      body: Obx(() {
        final game = controller.game;
        if (game.player1.isEmpty || game.player2.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (game.winner.isNotEmpty) {
          return Center(
            child: Text('${game.winner} wins!'),
          );
        }
        if (game.draw) {
          return Center(
            child: Text('Draw!'),
          );
        }
        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Material(
              color:
                  game.board[index].isEmpty ? Colors.white : Colors.grey[300],
              child: InkWell(
                onTap: () => controller.play(index),
                child: Center(
                  child: Text(
                    game.board[index],
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
