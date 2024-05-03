import 'package:coachingerbeton/controllers/languagechangecontroller/lanchngcontroller.dart';
import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      width: width(context) * .50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<LanguageChangeController>(builder: (context, value, child) {
            return PopupMenuButton(onSelected: (Language language) {
              if (Language.english.name == language.name) {
                value.changeLanguage(const Locale('en'));
              } else {
                value.changeLanguage(const Locale('bn'));
              }
            }, itemBuilder: (context) {
              return <PopupMenuEntry<Language>>[
                const PopupMenuItem(
                  value: Language.english,
                  child: Text('English'),
                ),
                const PopupMenuItem(
                  value: Language.bengali,
                  child: Text('বাংলা'),
                ),
              ];
            });
          }),
          Text(AppLocalizations.of(context)!.studentinformation),
        ],
      ),
    );
  }
}

enum Language { english, bengali }
