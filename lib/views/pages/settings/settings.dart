import 'package:coachingerbeton/controllers/lanchngcontroller.dart';
import 'package:coachingerbeton/controllers/themecontroller.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: titlePopins.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.flag),
              title: Text(
                "Language",
                style: titlePopins,
              ),
              // titleTextStyle: titlePopins,
              trailing: Consumer<LanguageChangeController>(
                  builder: (context, value, child) {
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
            ),
          ),
          Card(
              child: ListTile(
            leading: const Icon(Icons.dark_mode),
            trailing:
                Consumer<ThemeContoller>(builder: (context, value, child) {
              return Switch(
                  value: value.isDark,
                  onChanged: (v) {
                    setState(() {
                      value.changeTheme();
                    });
                  });
            }),
          ))
        ],
      ),
    );
  }
}

enum Language { english, bengali }
