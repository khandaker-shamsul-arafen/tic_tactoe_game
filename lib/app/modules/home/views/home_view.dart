import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTac Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                "Please Select Your Mood",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              // DropdownButtonHideUnderline(
              //   child: DropdownButton(
              //     dropdownColor: Colors.white70,
              //     value: controller.selectedPlayer.value,
              //     items: controller.ddl.value.map((String items) {
              //       return DropdownMenuItem(
              //         value: items,
              //         child: Text(
              //           items,
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       controller.selectedPlayer.value = value!;
              //       switch (value) {
              //         case "Single Player":
              //           Get.toNamed(Routes.SINGLE_PLAYER);
              //           break;
              //         case "Human Player":
              //           Get.toNamed(Routes.HUMAN);
              //           break;
              //       }
              //     },
              //     hint: Container(
              //       alignment: Alignment.centerRight,
              //       width: 210,
              //       child: const Text(
              //         'Select Player',
              //         textAlign: TextAlign.end,
              //         style: TextStyle(backgroundColor: Colors.amber),
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.SINGLE_PLAYER);
                    },
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.red),
                    //resetGame2,
                    child: const Text(
                      "Single",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.HUMAN);
                    },
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.red),
                    //resetGame2,
                    child: const Text(
                      "Human",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
