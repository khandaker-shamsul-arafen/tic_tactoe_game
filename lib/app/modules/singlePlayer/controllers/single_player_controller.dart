import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widget/custom_dialoge.dart';

class SinglePlayerController extends GetxController {
  //TODO: Implement SinglePlayerController

  RxList<String>? board = <String>[].obs;
  bool? gameOver;
  String? gameStatus;
  String? player;
  String? computer;

  // late Random random;

  @override
  void onInit() async {
    // print("call onInit");  // this line not printing
    newGame();
    handleComputerMove(Get.context);
    super.onInit();
  }

  void newGame() {
    board!.value = List.filled(9, '');
    gameOver = false;
    gameStatus = "Computer's turn";
    player = 'O';
    computer = 'X';
  }

  void handleComputerMove(context) {
    if (!gameOver!) {
      int bestScore = -1000;
      int index = -1;
      for (int i = 0; i < 9; i++) {
        if (board![i] == '') {
          board![i] = computer!;
          int score = minimax(board!, 5, false, computer!);
          board![i] = '';
          if (score > bestScore) {
            bestScore = score;
            index = i;
          }
        }
      }

      board![index] = computer!;
      if (checkWin(board!, computer!)) {
        gameOver = true;
        gameStatus = "Computer wins";
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Computer won",
                  "Press the reset button to start again",
                ));
      } else if (isBoardFull()) {
        gameOver = true;
        gameStatus = "Draw";
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Match Draw",
                  "Press the reset button to start again",
                ));
      } else {
        gameStatus = "Player X's turn";
      }
    }
  }

  bool isBoardFull() {
    for (int i = 0; i < (board?.length ?? 0); i++) {
      if (board![i] == '') {
        return false;
      }
    }
    return true;
  }

  int minimax(
      List<String> board, int depth, bool isMaximizingPlayer, String computer) {
    if (checkWin(board, computer)) {
      //   debugPrint("Win");
      return 10;
    }
    if (checkWin(board, getOtherPlayer(computer))) {
      //debugPrint("other Player");
      return -10;
    }

    if (isMaximizingPlayer) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        //  debugPrint("inside loop");
        if (board[i] == '') {
          board[i] = computer;
          int score = minimax(board, depth + 1, false, computer);
          board[i] = '';
          bestScore = max(score, bestScore);
          //  debugPrint("max Score $bestScore");
        }
      }
      return bestScore - depth;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        //  debugPrint("else Inside loop ");
        if (board[i] == '') {
          board[i] = getOtherPlayer(computer);
          int score = minimax(board, depth + 1, true, computer);
          board[i] = '';
          bestScore = min(score, bestScore);
          // debugPrint("min Score $bestScore");
        }
      }
      return bestScore + depth;
    }
  }

  int evaluateBoard(List<String> board, String computer) {
    if (checkWin(board, computer)) {
      return 100;
    } else if (checkWin(board, getOtherPlayer(computer))) {
      return -100;
    } else {
      int numComputerSymbols = 0;
      int numHumanSymbols = 0;
      for (int i = 0; i < 9; i++) {
        if (board[i] == computer) {
          numComputerSymbols++;
        } else if (board[i] != ' ') {
          numHumanSymbols++;
        }
      }
      return numComputerSymbols - numHumanSymbols;
    }
  }

  String getOtherPlayer(String computer) {
    return computer == 'X' ? 'O' : 'X';
  }

  List<int> getAvailableSpots(List<String> board) {
    List<int> availableSpots = [];

    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        availableSpots.add(i);
      }
    }

    return availableSpots;
  }

  bool checkWin(List<String> board, String player) {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i] == player &&
          board[i + 1] == player &&
          board[i + 2] == player) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] == player &&
          board[i + 3] == player &&
          board[i + 6] == player) {
        return true;
      }
    }

    // Check diagonals
    if (board[0] == player && board[4] == player && board[8] == player) {
      return true;
    }
    if (board[2] == player && board[4] == player && board[6] == player) {
      return true;
    }

    return false;
  }

  void handlePlayerMove(int index, context) {
    if (!gameOver! && board![index] == '') {
      board![index] = player!;
      if (checkWin(board!, player!)) {
        gameOver = true;
        gameStatus = "You win!";
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Human won",
                  "Press the reset button to start again",
                ));
      } else if (isBoardFull()) {
        gameOver = true;
        gameStatus = "Draw";
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Match Draw",
                  "Press the reset button to start again",
                ));
      } else {
        gameStatus = "Computer's turn";
        handleComputerMove(context);
      }
    }
  }

  void makeMove(int index, BuildContext context) {
    if (board![index] == '') {
      handlePlayerMove(index, context);
    }
  }

  resetGame(context) {
    // if (Navigator.canPop(context)) Navigator.pop(context);
    onInit();
    // board?.clear();
    // Get.toNamed(Routes.SINGLE_PLAYER);
  }

  modeChange(context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
