import 'package:flutter/material.dart';

class TicTacButton {
  final id;
  String text;
  bool enable;
  Color bg;

  TicTacButton(
      {this.id, this.text = "", this.enable = true, this.bg = Colors.grey});
}
