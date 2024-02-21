import 'package:esmabatu/controllers/main_controller.dart';
import 'package:esmabatu/pages/dugun_page.dart';
import 'package:esmabatu/pages/home_page.dart';
import 'package:esmabatu/pages/kina_page.dart';
import 'package:esmabatu/pages/nikah_page.dart';

import 'package:get/get.dart';

abstract class MyRoute {
  static const String main = "/";
  static const String weddingPage = "/dugun";
  static const String nikahPage = "/nikah";
  static const String kinaPage = "/kina";
}

abstract class GetRoute {
  static final List<GetPage<dynamic>> route = [
    GetPage(
      name: MyRoute.main,
      page: () {
        Get.put(
          MainController(),
        ).calculateRemainingTime();
        return const HomePage();
      },
      transition: Transition.noTransition,
    ),
    GetPage(
      name: MyRoute.weddingPage,
      page: () {
        return const DugunPage();
      },
      transition: Transition.noTransition,
    ),
    GetPage(
      name: MyRoute.nikahPage,
      page: () {
        return const NikahPage();
      },
      transition: Transition.noTransition,
    ),
    GetPage(
      name: MyRoute.kinaPage,
      page: () {
        return const KinaPage();
      },
      transition: Transition.noTransition,
    ),
  ];
}
