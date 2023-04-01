import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/human/bindings/human_binding.dart';
import '../modules/human/views/human_view.dart';
import '../modules/human2/bindings/human2_binding.dart';
import '../modules/human2/views/human2_view.dart';
import '../modules/singlePlayer/bindings/single_player_binding.dart';
import '../modules/singlePlayer/views/single_player_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_PLAYER,
      page: () => const SinglePlayerView(),
      binding: SinglePlayerBinding(),
    ),
    GetPage(
      name: _Paths.HUMAN,
      page: () => const HumanView(),
      binding: HumanBinding(),
    ),
    GetPage(
      name: _Paths.HUMAN2,
      page: () => const Human2View(),
      binding: Human2Binding(),
    ),
  ];
}
