import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'game.dart';

class Human2Controller extends GetxController {
  //TODO: Implement Human2Controller
  late String gameId;
  late String playerId;

  late Rx<Game> _game;
  late StreamSubscription _gameSubscription;

  @override
  void onInit() {
    super.onInit();
    _game = Game().obs;
  }

  void joinGame(String gameId, String playerId) {
    this.gameId = gameId;
    this.playerId = playerId;
    _gameSubscription = FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .snapshots()
        .listen((snapshot) {
      final game = Game.fromMap(snapshot.data()!);
      _game.value = game;
    });
  }

  void play(int index) {
    final board = _game.value.board;
    if (_game.value.turn != playerId || board[index].isNotEmpty) {
      return;
    }
    board[index] = playerId;
    _checkWinner();
    _nextTurn();
    _updateGame();
  }

  Game get game => _game.value;

  void _checkWinner() {
    final board = _game.value.board;
    const List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (final condition in winConditions) {
      final values = condition.map((index) => board[index]).toSet().toList();
      if (values.length == 1 && values[0].isNotEmpty) {
        _game.update((game) {
          game?.winner = playerId;
        });
        return;
      }
    }
    if (!board.contains('')) {
      _game.update((game) {
        game?.draw = true;
      });
    }
  }

  void _nextTurn() {
    _game.update((game) {
      game?.turn = game.turn == game.player1 ? game.player2 : game.player1;
    });
  }

  void _updateGame() {
    final game = _game.value;
    FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .update(game.toMap());
  }

  @override
  void onClose() {
    _gameSubscription.cancel();
    super.onClose();
  }
}
