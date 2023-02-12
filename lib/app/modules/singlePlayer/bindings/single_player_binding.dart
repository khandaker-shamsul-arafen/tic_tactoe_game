import 'package:get/get.dart';

import '../controllers/single_player_controller.dart';

class SinglePlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SinglePlayerController>(
      () => SinglePlayerController(),
    );
  }
}
