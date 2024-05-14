import 'package:coachingerbeton/models/data/student_info_sp.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/home_page.dart';
import 'package:coachingerbeton/views/pages/onboardings/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) => checkUser());
  }

  Future<void> checkUser() async {
    final bool result = await StudentInfoUtils.checkExistingUser();
    if (result) {
      StudentInfoUtils.getStudentInfo();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false);
    }
  }

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
