import 'package:flutter/material.dart';

import '../modules/singlePlayer/controllers/single_player_controller.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;

  //final VoidCallback callback;
  final actionText;

  CustomDialog(this.title, this.content,
      //this.callback,
      [this.actionText = "reset"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        //   ElevatedButton(onPressed: (){SinglePlayerController().resetGame(context);}, child: Text(actionText))
      ],
    );
  }
}
