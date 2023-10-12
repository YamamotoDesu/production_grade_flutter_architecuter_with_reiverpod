import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/common/views/splash.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/feature/home/view/home.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
  ],
);
