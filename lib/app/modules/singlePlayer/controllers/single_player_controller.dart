import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/custom_dialoge.dart';
import '../../../widget/tic_tac_button.dart';

class SinglePlayerController extends GetxController {
  //TODO: Implement SinglePlayerController

  var tictacButtonList = <TicTacButton>[].obs;
  var player1;
  var player2;
  var activeplayer;
  bool check = false;
  int x = 1,
      y = 1,
      z = 1;

  final count = 0.obs;

  @override
  void onInit() {
    tictacButtonList = addButton();
    super.onInit();
  }

  RxList<TicTacButton> addButton() {
    player1 = [];
    player2 = [];
    activeplayer = 1;

    RxList<TicTacButton> tictacButtons = [
      TicTacButton(id: 1),
      TicTacButton(id: 2),
      TicTacButton(id: 3),
      TicTacButton(id: 4),
      TicTacButton(id: 5),
      TicTacButton(id: 6),
      TicTacButton(id: 7),
      TicTacButton(id: 8),
      TicTacButton(id: 9),
    ].obs;
    return tictacButtons;
  }

  void startGame(int index, context) {
    if (activeplayer == 1) {
      tictacButtonList[index].txt = 'x';
      tictacButtonList[index].bg = Colors.purple.shade400;
      activeplayer = 2;
      player1.add(tictacButtonList[index].id);

      tictacButtonList.refresh();
      debugPrint("Player 1 Index ${player1.length}");
    } else if (activeplayer == 2) {
      tictacButtonList[index].txt = '0';
      tictacButtonList[index].bg = Colors.cyan.shade400;
      activeplayer = 1;
      player2.add(tictacButtonList[index].id);
      tictacButtonList.refresh();

      debugPrint("Player 2 Index ${player2.length}");
    }
    tictacButtonList[index].enable = false;

    int winnerName = winner(context);
    debugPrint("Winnername$winnerName");

    if (winnerName == -1) {
      if (tictacButtonList.every((p) => p.txt != "")) {
        for (int i = 0; i < tictacButtonList.length; i++) {
          debugPrint("dgdgd${tictacButtonList[i].txt}");
        }

        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Game tied",
                  "Press the reset button to star again",
                ));
      } else {
        // debugPrint("InSide WinnerName");
        activeplayer == 2 ? autoPlay(context) : null;
      }
    }
  }

  void autoPlay(context) {
    var emptyCells = [];
    var list = List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = tictacButtonList.indexWhere((p) => p.id == cellID);

    // if (player1.contains(7)) {
    //   debugPrint("OutSide WinnerName");

    //   check=false;
    // }
    if (player1.contains(7) && x == 1) {
      startGame(5, context);
      x = 0;
    } else if (player1.contains(2) && y == 1) {
      debugPrint("OutSide WinnerName");
      startGame(0, context);
      y = 0;
    } else if (player1.contains(5) && z == 1) {
      debugPrint("OutSide WinnerName");
      startGame(7, context);
      z = 0;
    } else {
      startGame(i, context);
    }

    //  debugPrint("player1[6]${player1[6]}");
  }

  int winner(context) {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    if (player1.contains(6) && player1.contains(3) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(6) && player2.contains(3) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(5) && player1.contains(3) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(5) && player2.contains(3) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        debugPrint("Winner player 1");
        // Custom dialog
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Player 1 won",
                  "Press the reset button to start again",
                ));
      } else {
        debugPrint("Winner player 2");
        // custom dailog
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Player 2 won",
                  "Press the reset button to start again",
                ));
      }
    }

    return winner;
  }

  resetGame(context) {
    if (Navigator.canPop(context)) Navigator.pop(context);

    debugPrint("Player 2 Index ${player2.length}");
    debugPrint("Player 2 Index ${player2.length}");
    tictacButtonList = addButton();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
