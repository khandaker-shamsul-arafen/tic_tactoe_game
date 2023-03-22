import 'package:flutter/material.dart';

class Bot extends StatefulWidget {
  const Bot({Key? key}) : super(key: key);

  @override
  State<Bot> createState() => _BotState();
}

class _BotState extends State<Bot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Strong Bot "),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Welcome text
          Text(
            "Welcome to Flutter Tic Tac Toe!",
            style: TextStyle(fontSize: 20),
          ),
          // New game button
          Center(
            child: ButtonTheme(
              minWidth: 200,
              height: 80,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Text(
                  "New game!",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          // Win statistic widget
          // StreamBuilder(
          //     stream: _presenter.buildVictoriesStream(),
          //     builder: (context, snapshot) {
          //       var playerCount = _presenter.getVictoryCountFromStream(snapshot);
          //       if (playerCount <= 0) {
          //         return Text("No AI wins yet!", style: TextStyle(fontSize: 15));
          //       }
          //
          //       return Text("Number of AI wins: $playerCount", style: TextStyle(fontSize: 15));
          //     }),
        ],
      ),
    );
  }
}
// class GamePage extends StatefulWidget {
//
//   final String title;
//
//   GamePage(this.title);
//
//   @override
//   GamePageState createState() => GamePageState();
// }
// class GamePageState extends State<GamePage> {
//
//   GamePageState() {
//   this._presenter = GamePresenter(_movePlayed, _onGameEnd);
//   }
//   void _movePlayed(int idx) {
//     setState(() {
//       board[idx] = _currentPlayer;
//
//       if (_currentPlayer == Ai.HUMAN) {
//         // switch to AI player
//         _currentPlayer = Ai.AI_PLAYER;
//         _presenter.onHumanPlayed(board);
//
//       } else {
//         _currentPlayer = Ai.HUMAN;
//       }
//     });
//   }
//   void onHumanPlayed(List<int> board) async {
//
//     // evaluate the board after the human player
//     int evaluation = Utils.evaluateBoard(board);
//     if (evaluation != Ai.NO_WINNERS_YET) {
//       onGameEnd(evaluation);
//       return;
//     }
//
//     // calculate the next move, could be an expensive operation
//     int aiMove = await Future(() => _aiPlayer.play(board, Ai.AI_PLAYER));
//
//     // do the next move
//     board[aiMove] = Ai.AI_PLAYER;
//
//     // evaluate the board after the AI player move
//     evaluation = Utils.evaluateBoard(board);
//     if (evaluation != Ai.NO_WINNERS_YET)
//       onGameEnd(evaluation);
//     else
//       showMoveOnUi(aiMove);
//   }
//   @override
//   Widget build(BuildContext context) {
//
//   return Scaffold(
//   appBar: AppBar(
//   title: Text(widget.title),
//   ),
//   body: Column(
//   children: <Widget>[
//   Padding(
//   padding: const EdgeInsets.all(60),
//   child: Text("You are playing as X", style: TextStyle(fontSize: 25),),
//   ),
//   Expanded(
//   child: GridView.count(
//   crossAxisCount: 3,
//   // generate the widgets that will display the board
//   children: List.generate(9, (idx) {
//   return Field(idx: idx, onTap: _movePlayed, playerSymbol: getSymbolForIdx(idx));
//   }),
//   ),
//   ),
//   ],
//   ),
//   );
//   }
// }
// class Field extends StatelessWidget {
//
//   Field({this.idx, this.onTap, this.playerSymbol});
//
//
//   ...
//   @override
//   Widget build(BuildContext context) {
//   return GestureDetector(
//   onTap: _handleTap,
//   child: Container(
//   margin: const EdgeInsets.all(0.0),
//   decoration: BoxDecoration(
//   border: _determineBorder()
//   ),
//   child: Center(
//   child: Text(playerSymbol, style: TextStyle(fontSize: 50))
//   ),
//   ),
//   );
//   }
// }
// Border _determineBorder() {
//   Border determinedBorder = Border.all();
//
//   switch(idx) {
//     case 0:
//       determinedBorder = Border(bottom: _borderSide, right: _borderSide);
//       break;
//     case 1:
//       determinedBorder = Border(left: _borderSide, bottom: _borderSide, right: _borderSide);
//       break;
//     case 2:
//       determinedBorder = Border(left: _borderSide, bottom: _borderSide);
//       break;
//     case 3:
//       determinedBorder = Border(bottom: _borderSide, right: _borderSide, top: _borderSide);
//       break;
//     case 4:
//       determinedBorder = Border(left: _borderSide, bottom: _borderSide, right: _borderSide, top: _borderSide);
//       break;
//     case 5:
//       determinedBorder = Border(left: _borderSide, bottom: _borderSide, top: _borderSide);
//       break;
//     case 6:
//       determinedBorder = Border(right: _borderSide, top: _borderSide);
//       break;
//     case 7:
//       determinedBorder = Border(left: _borderSide, top: _borderSide, right: _borderSide);
//       break;
//     case 8:
//       determinedBorder = Border(left: _borderSide, top: _borderSide);
//       break;
//   }
//
//   return determinedBorder;
// }
// final Function(int idx) onTap;
// void _handleTap() {
//   // only send tap events if the field is empty
//   if (playerSymbol == "")
//     onTap(idx);
// }
// int _getBestScore(List<int> board, int currentPlayer) {
//   int evaluation = Utils.evaluateBoard(board);
//
//   if (evaluation == currentPlayer)
//     return WIN_SCORE;
//
//   if (evaluation == DRAW)
//     return DRAW_SCORE;
//
//   if (evaluation == Utils.flipPlayer(currentPlayer)) {
//     return LOSE_SCORE;
//   }
//
//   return _getBestMove(board, currentPlayer).score;
// }
// /// This is where the actual Minimax algorithm is implemented
// Move _getBestMove(List<int> board, int currentPlayer) {
//   // try all possible moves
//   List<int> newBoard;
//   // will contain our next best score
//   Move bestMove = Move(score: -10000, move: -1);
//
//   for(int currentMove = 0; currentMove < board.length; currentMove++) {
//     if (!Utils.isMoveLegal(board, currentMove)) continue;
//
//     // we need a copy of the initial board so we don't pollute our real board
//     newBoard = List.from(board);
//
//     // make the move
//     newBoard[currentMove] = currentPlayer;
//
//     // solve for the next player
//     // what is a good score for the opposite player is opposite of good score for us
//     int nextScore = -_getBestScore(newBoard, Utils.flipPlayer(currentPlayer));
//
//     // check if the current move is better than our best found move
//     if (nextScore > bestMove.score) {
//       bestMove.score = nextScore;
//       bestMove.move = currentMove;
//     }
//   }
//
//   return bestMove;
// }
