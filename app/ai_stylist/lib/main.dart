import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/outfit_ideas_screen.dart';
import 'theme/app_theme.dart';

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/analysis',
      builder:
          (context, state) => const AnalysisScreen(
            colorType: 'True Summer',
            styleType: 'Dramatic',
            bodyType: 'Triangle',
            outfitMatch: true,
          ),
    ),
    GoRoute(
      path: '/outfits',
      builder: (context, state) => const OutfitIdeasScreen(),
    ),
  ],
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI Stylist',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
