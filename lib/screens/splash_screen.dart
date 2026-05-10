import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool crescer = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        crescer = true;
      });
    });
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 128, 0),

      body: AnimatedAlign(
        alignment: crescer ? const Alignment(-1.5, 0) : Alignment.center,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        child: AnimatedScale(
          scale: crescer ? 100 : 1.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: const Icon(
            Icons.account_balance_wallet,
            size: 80,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
