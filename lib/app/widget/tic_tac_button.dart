import 'package:flutter/material.dart';

class TicTacButton {
  final id;
  String txt;
  bool enable;
  Color bg;

  TicTacButton(
      {this.id, this.txt = "", this.enable = true, this.bg = Colors.grey});
}
