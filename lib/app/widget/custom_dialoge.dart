import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;

  // final VoidCallback callback;
  //final actionText;

  const CustomDialog(
    this.title,
    this.content,
    //this.actionText,
    //  this.callback,[this.actionText="reset"]
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        //  ElevatedButton(onPressed: callback, child: Text(actionText))
      ],
    );
  }
}
