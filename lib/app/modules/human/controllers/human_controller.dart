import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widget/custom_dialoge.dart';
import '../../../widget/tic_tac_button.dart';

class HumanController extends GetxController {
  //TODO: Implement HumanController
  var tictacButtonList = <TicTacButton>[].obs;
  var player1;
  var player2;
  var activeplayer;
  bool check = false;
  int x = 1, y = 1, z = 1;
  //////////////////////////////////////////////////////
  late DatabaseReference _gameRef;
  // late String _player1='';
  // late String _player2='';
  // final RxBool gameOver = false.obs;
  // final RxString currentPlayer = 'Player 1'.obs;
  // late List<List<String>> board = List.generate(3, (_) => List.filled(3, '')).obs;
  //List<List<String>> get board => _board;


  @override
  void onInit() {
    //tictacButtonList = addButton();
    //late List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));

   // initGame();
    super.onInit();
  }
  // void initGame() async {
  //   await Firebase.initializeApp();
  //   _gameRef = FirebaseDatabase.instance.ref().child('game');
  //   gameOver.value = false;
  //
  //
  //   // Check if there's an existing game in progress
  //   _gameRef.once().then((snapshot) {
  //     if (snapshot.snapshot.value != null) {
  //       //Map<String, dynamic> data = snapshot.snapshot.value.cast<String, dynamic>();
  //       Map<String, dynamic>? data = snapshot.snapshot.value as Map<String, dynamic>?;
  //       if (data != null) {
  //         Map<String, dynamic> boardData = data['board'] as Map<String, dynamic>;
  //         List<List<String>> board = boardData.values.toList().cast<List<String>>().toList();
  //         // continue with your code
  //       }
  //       _player1 = data!['player1'] as String;
  //       _player2 = data['player2'] as String;
  //       board = List<List<String>>.from(
  //         data['board'].map(
  //               (row) => List<String>.from(row),
  //         ),
  //       );
  //       currentPlayer.value = data['currentPlayer'] as String;
  //       update();
  //     }else {
  //       // Start a new game
  //       _player1 = 'Player 1';
  //       _player2 = 'Player 2';
  //       board = List.generate(
  //         3,
  //             (_) => List.generate(3, (_) => ''),
  //       );
  //       currentPlayer.value = _player1;
  //       _gameRef.set({
  //         'player1': _player1,
  //         'player2': _player2,
  //         'board': board,
  //         'currentPlayer': currentPlayer.value,
  //       });
  //       update();
  //     }
  //   });
  //
  //   // Listen for changes in the game state
  //   _gameRef.onValue.listen((event) {
  //     final data = event.snapshot.value as Map<String, dynamic>?;
  //     if (data != null) {
  //       _player1 = data['player1'] as String;
  //       _player2 = data['player2'] as String;
  //       board = List<List<String>>.from(
  //         data['board'].map(
  //               (row) => List<String>.from(row),
  //         ),
  //       );
  //       currentPlayer.value = data['currentPlayer'] as String;
  //       gameOver.value = data['gameOver'] ?? false;
  //       update();
  //     }
  //   });
  // }
  //
  // void makeMove(int row, int col) {
  //   if (board[row][col] == '') {
  //     board[row][col] = currentPlayer.value;
  //
  //     // Check for a win or draw
  //     if (_checkForWin(row, col)) {
  //       gameOver.value = true;
  //       _gameRef.update({'gameOver': true});
  //     } else if (_checkForDraw()) {
  //       gameOver.value = true;
  //       _gameRef.update({'gameOver': true});
  //     } else {
  //       currentPlayer.value = currentPlayer.value == _player1 ? _player2 : _player1;
  //       _gameRef.update({
  //         'board': board,
  //         'currentPlayer': currentPlayer.value,
  //       });
  //     }
  //     update();
  //   }
  // }
  // bool _checkForDraw() {
  //   for (var i = 0; i < board.length; i++) {
  //     for (var j = 0; j < board[i].length; j++) {
  //       if (board[i][j] == '') {
  //         // If there's an empty cell, the game is not over yet
  //         return false;
  //       }
  //     }
  //   }
  //
  //   // If we get here, all cells are filled and no one has won, so it's a draw
  //   return true;
  // }
  //
  // bool _checkForWin(int row, int col) {
  //   // Check row
  //   if (board[row].every((val) => val == currentPlayer.value)) {
  //     return true;
  //   }
  //
  //   // Check column
  //   if (board.every((row) => row[col] == currentPlayer.value)) {
  //     return true;
  //   }
  //
  //   // Check diagonal
  //   if (row == col) {
  //     if (board.every((row) => row[board.indexOf(row)] == currentPlayer.value)) {
  //       return true;
  //     }
  //   }
  //
  //   // Check anti-diagonal
  //   if (row + col == 2) {
  //     if (board.every((row) => row[2 - board.indexOf(row)] == currentPlayer.value)) {
  //       return true;
  //     }
  //   }
  //
  //   return false;
  // }
  //
  //
  // Future<void> resetGame() async {
  //   board = List.generate(
  //     3,
  //         (_) => List.generate(3, (_) => ''),
  //   );
  //   currentPlayer.value = _player1;
  //   gameOver.value = false;
  //   await _gameRef.update({
  //       'board': board,
  //     'currentPlayer': currentPlayer.value,
  //     'gameOver': gameOver.value,
  //   });
  //   update();
  // }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference games = FirebaseFirestore.instance.collection('games');
  RxBool isLoading = false.obs;
  RxString gameId = ''.obs;
  RxString player = ''.obs;
  RxString currentPlayer = ''.obs;
  RxList<String> gameBoard = List.filled(9, '').obs;
  RxString winner = ''.obs;

  Future<void> createGame() async {
    isLoading.value = true;
    DocumentReference ref = await games.add({
      'player1': '',
      'player2': '',
      'gameBoard': ['', '', '', '', '', '', '', '', ''],
      'currentPlayer': '',
      'winner': '',
    });
    gameId.value = ref.id;
    isLoading.value = false;
  }

  Future<void> joinGame(String gameId) async {
    isLoading.value = true;
    DocumentSnapshot gameSnapshot = await games.doc(gameId).get();
    if (gameSnapshot.exists) {
      if (gameSnapshot.data()!['player2'] != '') {
        Get.snackbar('Error', 'Game already has two players');
      } else {
        await games.doc(gameId).update({
          'player2': player.value,
          'currentPlayer': gameSnapshot.data()!['player1'] ,
        });
        this.gameId.value = gameId;
        updateGameState(gameSnapshot);
      }
    } else {
      Get.snackbar('Error', 'Game not found');
    }
    isLoading.value = false;
  }

  void updateGameState(DocumentSnapshot snapshot) {
    gameBoard.value = List<String>.from(snapshot.data()!['gameBoard']);
    currentPlayer.value = snapshot.data()!['currentPlayer'];
    winner.value = snapshot.data()!['winner'];
  }

  Future<void> makeMove(int index) async {
    String newCurrentPlayer;
    DocumentSnapshot<Object?> gameSnapshot = await games.doc(gameId.value).get();
    if (gameBoard[index] != '' || winner.value != '') return;
    if (player.value == currentPlayer.value) {
      gameBoard[index] = player.value;
      int moveCount = gameBoard.where((value) => value != '').length;
      String newWinner = checkWinner(gameBoard, moveCount);
      if (newWinner != '') {
        await games.doc(gameId.value).update({'winner': newWinner});
        winner.value = newWinner;
      } else {
        String newCurrentPlayer = (currentPlayer.value == gameSnapshot.data()!['player1']) ? gameSnapshot.data()!['player2'] : gameSnapshot.data()!['player1'];
        await games.doc(gameId.value).update({
          'gameBoard': gameBoard.toList(),
          'currentPlayer': newCurrentPlayer,
        });
        currentPlayer.value = newCurrentPlayer;
      }
    }
  }String checkWinner(List<String> board, int moveCount) {
    List<List<int>> winningPositions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6], // diagonals
    ];

    for (List<int> position in winningPositions) {
      String symbol = board[position[0]];
      if (symbol != '' && board[position[1]] == symbol && board[position[2]] == symbol) {
        return symbol;
      }
    }

    if (moveCount == 9) {
      return 'draw';
    }

    return '';
  }



  // RxList<TicTacButton> addButton() {
  //   player1 = [];
  //   player2 = [];
  //   activeplayer = 1;
  //
  //   RxList<TicTacButton> tictacButtons = [
  //     TicTacButton(id: 1),
  //     TicTacButton(id: 2),
  //     TicTacButton(id: 3),
  //     TicTacButton(id: 4),
  //     TicTacButton(id: 5),
  //     TicTacButton(id: 6),
  //     TicTacButton(id: 7),
  //     TicTacButton(id: 8),
  //     TicTacButton(id: 9),
  //   ].obs;
  //   return tictacButtons;
  // }

  // void startGame(int index, context) {
  //   if (activeplayer == 1) {
  //     tictacButtonList[index].txt = 'X';
  //     tictacButtonList[index].bg = Colors.red;
  //     activeplayer = 2;
  //     player1.add(tictacButtonList[index].id);
  //
  //     tictacButtonList.refresh();
  //     debugPrint("Player 1 Index ${player1.length}");
  //   } else if (activeplayer == 2) {
  //     tictacButtonList[index].txt = 'O';
  //     tictacButtonList[index].bg = Colors.blue;
  //     activeplayer = 1;
  //     player2.add(tictacButtonList[index].id);
  //     tictacButtonList.refresh();
  //
  //     debugPrint("Player 2 Index ${player2.length}");
  //   }
  //   tictacButtonList[index].enable = false;
  //
  //   int winnerName = winner(context);
  //   debugPrint("Winnername$winnerName");
  //
  //   if (winnerName == -1) {
  //     if (tictacButtonList.every((p) => p.txt != "")) {
  //       for (int i = 0; i < tictacButtonList.length; i++) {
  //         debugPrint("dgdgd${tictacButtonList[i].txt}");
  //       }
  //
  //       showDialog(
  //           context: context,
  //           builder: (_) => CustomDialog(
  //             "Match Draw",
  //                 "Press the reset button to star again",
  //               ));
  //     }
  //   }
  // }
  //
  // int winner(context) {
  //   var winner = -1;
  //   if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(6) && player1.contains(3) && player1.contains(9)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(6) && player2.contains(3) && player2.contains(9)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
  //     winner = 2;
  //   }
  //
  //   if (player1.contains(5) && player1.contains(3) && player1.contains(7)) {
  //     winner = 1;
  //   }
  //   if (player2.contains(5) && player2.contains(3) && player2.contains(7)) {
  //     winner = 2;
  //   }
  //
  //   if (winner != -1) {
  //     if (winner == 1) {
  //       debugPrint("Winner player 1");
  //       // Custom dialog
  //       showDialog(
  //           context: context,
  //           builder: (_) => CustomDialog(
  //                 "Player 1 won",
  //                 "Press the reset button to start again",
  //               ));
  //     } else {
  //       debugPrint("Winner player 2");
  //       // custom dailog
  //       showDialog(
  //           context: context,
  //           builder: (_) => CustomDialog(
  //                 "Player 2 won",
  //                 "Press the reset button to start again",
  //               ));
  //     }
  //   }
  //
  //   return winner;
  // }

  // resetGame(context) {
  //   // if (Navigator.canPop(context)) Navigator.pop(context);
  //
  //   // Get.toNamed(Routes.HUMAN);
  //   tictacButtonList.clear();
  //   onInit();
  //
  //   //tictacButtonList = addButton();
  // }

  modeChange(context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
