import 'package:flutter/material.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/utills/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
