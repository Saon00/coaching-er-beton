import 'package:coachingerbeton/controllers/lanchngcontroller.dart';
import 'package:coachingerbeton/controllers/themecontroller.dart';
import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/onboardings/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String lanCode = sharedPreferences.getString('lang_code') ?? "";
  runApp(MyApp(locale: lanCode));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    // ThemeData themeData = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageChangeController()),
        ChangeNotifierProvider(create: (context) => ThemeContoller()),
      ],
      child: Consumer<LanguageChangeController>(
        builder: (context, value, child) {
          if (locale.isEmpty) {
            value.changeLanguage(const Locale('en'));
          }
          return MaterialApp(
            locale: locale == ""
                ? const Locale('en')
                : value.locale ?? const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('bn')],
            // theme: themeData.copyWith(
            //     appBarTheme: AppBarTheme(
            //         color: primaryColor,
            //         centerTitle: true,
            //         titleTextStyle: titlePopins.copyWith(
            //             fontSize: 20,
            //             color: blackColor,
            //             fontWeight: FontWeight.bold))),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme: Provider.of<ThemeContoller>(context).themeData,
            
          );
        },
      ),
    );
  }
}
