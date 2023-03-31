import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/custom_dialoge.dart';
import '../../../widget/tic_tac_button.dart';

class HumanController extends GetxController {
  //TODO: Implement HumanController
  RxList ticTacButtonList = <TicTacButton>[].obs;

  //Stream collectionStream = FirebaseFirestore.instance.collection('board').snapshots();
//  Stream documentStream = FirebaseFirestore.instance.collection('user').doc('player').snapshots(); //read Option
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  CollectionReference board = FirebaseFirestore.instance.collection('board'); //Write Option
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  int activePlayer = 0;
  int winnerCheck = 0;

  @override
  void onInit() {
    users.doc('player').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        activePlayer = documentSnapshot['activePlayer'];
        debugPrint("active Player$activePlayer");
      }
    });
    ticTacButtonList = addButton();
    super.onInit();
  }

  RxList<TicTacButton> addButton() {
    // activePlayer = 2;

    RxList<TicTacButton> ticTacButtons = [
      TicTacButton(id: 0),
      TicTacButton(id: 1),
      TicTacButton(id: 2),
      TicTacButton(id: 3),
      TicTacButton(id: 4),
      TicTacButton(id: 5),
      TicTacButton(id: 6),
      TicTacButton(id: 7),
      TicTacButton(id: 8),
    ].obs;
    return ticTacButtons;
  }

  void startGame(int index, context) {
    users.doc('player').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        activePlayer = documentSnapshot['activePlayer'];
        debugPrint("active Player$activePlayer");
      }
    });

    if (activePlayer == 1) {
      board.doc('$index').update({'text': 'X'});

      board.doc('$index').get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          ticTacButtonList[index].text = documentSnapshot['text'];
          debugPrint("active Player${ticTacButtonList[index].text}");
        }
      });
      ticTacButtonList[index].bg = Colors.red;
      users.doc('player').update({'activePlayer': 2});

      ticTacButtonList.refresh();
    } else if (activePlayer == 2) {
      board.doc('$index').update({'text': '0'});
      ticTacButtonList[index].bg = Colors.blue;
      users.doc('player').update({'activePlayer': 1}); //1st player ar ID Hobe
      board.doc('$index').get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          ticTacButtonList[index].text = documentSnapshot['text'];
          debugPrint(
              "active Playerrrrrrrrrrrrrrrrrrrrrr${ticTacButtonList[index].text}");
        }
      });

      ticTacButtonList.refresh();
    }
    ticTacButtonList[index].enable = false;

    int winnerName = winner(context);
    debugPrint("Winnername$winnerName");

    if (winnerName == -1) {
      if (ticTacButtonList.every((p) => p.text != "")) {
        for (int i = 0; i < ticTacButtonList.length; i++) {
          //ata kal dekha jabe
          debugPrint("dgdgd${ticTacButtonList[i].text}");
        }

        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  "Match Draw",
                  "Press the reset button to star again",
                ));
      }
    }
  }

  int winner(context) {
    var winner = -1;

    if (ticTacButtonList[0].text == 'X' &&
        ticTacButtonList[1].text == 'X' &&
        ticTacButtonList[2].text == 'X') {
      //player 1 read from Database
      winner = 1; //player1 Id
    }
    if (ticTacButtonList[0].text == '0' &&
        ticTacButtonList[1].text == '0' &&
        ticTacButtonList[2].text == '0') {
      //player 2 read from Database
      winner = 2; // player 2 Id
    }

    if (ticTacButtonList[4].text == 'X' &&
        ticTacButtonList[5].text == 'X' &&
        ticTacButtonList[3].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[4].text == '0' &&
        ticTacButtonList[5].text == '0' &&
        ticTacButtonList[3].text == '0') {
      winner = 2;
    }

    if (ticTacButtonList[7].text == 'X' &&
        ticTacButtonList[8].text == 'X' &&
        ticTacButtonList[6].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[7].text == '0' &&
        ticTacButtonList[8].text == '0' &&
        ticTacButtonList[6].text == '0') {
      winner = 2;
    }

    if (ticTacButtonList[0].text == 'X' &&
        ticTacButtonList[3].text == 'X' &&
        ticTacButtonList[6].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[0].text == '0' &&
        ticTacButtonList[3].text == '0' &&
        ticTacButtonList[6].text == '0') {
      winner = 2;
    }

    if (ticTacButtonList[1].text == 'X' &&
        ticTacButtonList[4].text == 'X' &&
        ticTacButtonList[7].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[1].text == '0' &&
        ticTacButtonList[4].text == '0' &&
        ticTacButtonList[7].text == '0') {
      winner = 2;
    }

    if (ticTacButtonList[5].text == 'X' &&
        ticTacButtonList[2].text == 'X' &&
        ticTacButtonList[8].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[2].text == '0' &&
        ticTacButtonList[5].text == '0' &&
        ticTacButtonList[8].text == '0') {
      winner = 2;
    }

    if (ticTacButtonList[0].text == 'X' &&
        ticTacButtonList[4].text == 'X' &&
        ticTacButtonList[8].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[0].text == '0' &&
        ticTacButtonList[4].text == '0' &&
        ticTacButtonList[8].text == '0') {
      winner = 2;
    }

    if (ticTacButtonList[4].text == 'X' &&
        ticTacButtonList[2].text == 'X' &&
        ticTacButtonList[6].text == 'X') {
      winner = 1;
    }
    if (ticTacButtonList[4].text == '0' &&
        ticTacButtonList[2].text == '0' &&
        ticTacButtonList[6].text == '0') {
      winner = 2;
    }
    users.doc('player').update({'winner': winner});

    users.doc('player').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        winnerCheck = documentSnapshot['winner'];
        debugPrint("winnerCheck${winnerCheck.runtimeType}");
        if (winnerCheck==1) {
          //! ar jaygay Player 1ar ID hobe
          debugPrint("Winner player 1");
          // Custom dialog
          showDialog(
              context: context,
              builder: (_) => CustomDialog(
                "Player 1 won",
                "Press the reset button to start again",
              ));
        } else if (winnerCheck == 2) {
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
    });
    debugPrint("winnerChechbbfv${winnerCheck.runtimeType}");




    return winner;
  }

  resetGame(context) {
    ticTacButtonList.clear();
    onInit();
  }

  modeChange(context) {
    Get.back();
  }
}
