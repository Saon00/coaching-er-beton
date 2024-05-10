import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wallet.png',
              scale: 2.5,
            ),
            Text("Coaching er Beton",
                style: titlePopins.copyWith(
                    fontSize: 30, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
