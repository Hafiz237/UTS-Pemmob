import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KUIS KITA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Container(
          width: Responsive.contentWidth(context) * 0.8,
          padding: EdgeInsets.all(Responsive.w(context, 0.05)),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(Responsive.w(context, 0.04)),
          ),
          child: Text(
            'Halo Programmer!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(context, 0.07),
              fontWeight: FontWeight.w700,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}