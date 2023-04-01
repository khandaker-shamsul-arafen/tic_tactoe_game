import 'package:get/get.dart';

import '../controllers/human2_controller.dart';

class Human2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Human2Controller>(
      () => Human2Controller(),
    );
  }
}
