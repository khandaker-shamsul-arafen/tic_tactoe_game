import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void startGame(int index) {
    if (activeplayer == 1) {
      debugPrint("Shanto");
      tictacButtonList[index].txt = 'x';
      tictacButtonList[index].bg = Colors.purple.shade400;
      activeplayer = 2;
      player1.add(tictacButtonList[index].id);
    } else {
      tictacButtonList[index].txt = '0';
      tictacButtonList[index].bg = Colors.cyan.shade400;

      activeplayer = 1;
      player2.add(tictacButtonList[index].id);
    }
    tictacButtonList[index].enable = false;
    tictacButtonList.refresh();
    // int winner=checkWinner();
    // if(winner==-1){
    //   if(buttonList.every((p) => p.text!="")){
    //     showDialog(context: context,
    //         builder: (_)=>CustomDailog("Game tied", "Press the reset button to star again", resetGame));
    //   }else{
    //     activeplayer==2?autoPlay():null;
    //   }
    // }
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
