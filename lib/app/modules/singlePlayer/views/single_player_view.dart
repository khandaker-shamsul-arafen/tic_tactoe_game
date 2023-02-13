import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/single_player_controller.dart';

class SinglePlayerView extends GetView<SinglePlayerController> {
  const SinglePlayerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('SinglePlayerView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text("sfgshfbshf"),
            Row(
              children: [],
            )
          ],
        ));
  }
}
