import 'package:get/get.dart';

import '../controllers/human_controller.dart';

class HumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HumanController>(
      () => HumanController(),
    );
  }
}
