import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/home_page.dart';
import 'package:coachingerbeton/views/pages/students/studentt_information.dart';
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
    ThemeData themeData = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberListProvider())
      ],
      child: MaterialApp(
        
        theme: themeData.copyWith(
            appBarTheme: AppBarTheme(
                color: primaryColor,
                centerTitle: true,
                titleTextStyle: titlePopins.copyWith(
                    fontSize: 20,
                    color: blackColor,
                    fontWeight: FontWeight.bold))),
        debugShowCheckedModeBanner: false,
        home: const StudentInformationPage(),
      ),
    );
  }
}
