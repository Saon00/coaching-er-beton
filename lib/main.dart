import 'package:coachingerbeton/junk/first.dart';
import 'package:coachingerbeton/views/pages/spalsh_screen.dart';
import 'package:coachingerbeton/views/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'junk/list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberListProvider())
      ],
      child:  MaterialApp(
        // theme: ThemeData(scaffoldBackgroundColor: Colors.green),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}
