import 'package:esmabatu/firebase_options.dart';
import 'package:esmabatu/route.dart';
import 'package:esmabatu/utils/bindings.dart';
import 'package:esmabatu/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: appTitle,
      getPages: GetRoute.route,
      defaultTransition: Transition.noTransition,
      routerDelegate: AppRouterDelegate(),
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      fallbackLocale: const Locale("tr"),
      theme: ThemeData(fontFamily: 'Pacifico'),
      // theme: Colors.blueGrey
      themeMode: ThemeMode.dark,
    );
  }
}

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute(MyRoute.main)!.currentPage!],
    );
  }
}
