import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/custom_dialoge.dart';
import '../../../widget/tic_tac_button.dart';

class SinglePlayerController extends GetxController {
  //TODO: Implement SinglePlayerController
  //late List<TicTacButton> tictacButtonList;
  var tictacButtonList = <TicTacButton>[].obs;
  var player1;
  var player2;
  var activeplayer;

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
    // if(winnerName==-1){
    //   if(tictacButtonList.every((p) => p.txt!="")){
    //     showDialog(context: context,
    //         builder: (_)=>CustomDialog("Game tied", "Press the reset button to star again",));
    //   }else{
    //   //  activeplayer==2?autoPlay():null;
    //   }
    // }
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
                "Player 1 won", "Press the reset button to start again"));
      } else {
        debugPrint("Winner player 2");
        // custom dailog
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                "Player 2 won", "Press the reset button to start again"));
      }
    }

    return winner;
  }

  resetGame(context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
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
