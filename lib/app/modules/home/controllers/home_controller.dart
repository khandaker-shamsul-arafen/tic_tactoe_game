import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString selectedPlayer = "Single Player".obs;
  RxList<String> ddl = ["Single Player", "Human Player"].obs;

  List<DropdownMenuItem<String>> dropDownItem() {
    return ddl.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(
          items,
        ),
      );
    }).toList();
  }

  final count = 0.obs;
}
