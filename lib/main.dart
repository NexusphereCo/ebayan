import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(const InitApp());

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eBayan',
      theme: EBTheme.data(),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
