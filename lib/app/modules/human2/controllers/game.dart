class Game {
  late String player1;
  late String player2;
  late String turn;
  late List<String> board;
  late String winner;
  late bool draw;

  Game({
    this.player1 = '',
    this.player2 = '',
    this.turn = '',
    this.board = const ['', '', '', '', '', '', '', '', ''],
    this.winner = '',
    this.draw = false,
  });

  Game.fromMap(Map<String, dynamic> map) {
    player1 = map['player1'] ?? '';
    player2 = map['player2'] ?? '';
    turn = map['turn'] ?? '';
    board =
        List<String>.from(map['board'] ?? ['', '', '', '', '', '', '', '', '']);
    winner = map['winner'] ?? '';
    draw = map['draw'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'player1': player1,
      'player2': player2,
      'turn': turn,
      'board': board,
      'winner': winner,
      'draw': draw,
    };
  }
}
