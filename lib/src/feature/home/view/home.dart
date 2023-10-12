import 'package:flutter/material.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/feature/home/view/product/view/wigets/products.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/res/string.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routePath = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: const ProductsList(),
    );
  }
}
