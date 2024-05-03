import 'package:coachingerbeton/views/pages/onboardings/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: key,
            child: ListView(
              // shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/info.svg'),
                // SizedBox(height: 20,),
                Text(
                  "Welcome",
                  style: titlePopins.copyWith(fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Name form field
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "name required";
                    }
                    return null;
                  },
                  controller: name,
                  style: titlePopins.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                  decoration: InputDecoration(
                      hintText: "enter your display name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),

                // goto next page button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.withOpacity(0.7)),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (route) => false);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: titlePopins.copyWith(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
