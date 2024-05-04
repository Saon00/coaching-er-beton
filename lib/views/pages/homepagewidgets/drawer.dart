import 'package:coachingerbeton/controllers/languagechangecontroller/lanchngcontroller.dart';
import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final TextEditingController languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      width: width(context) * .50,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<LanguageChangeController>(
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

            // Consumer<LanguageChangeController>(
            //     builder: (builder, value, context) {
            //   return DropdownButton(
            //     onTap: (Language language){
            //       if (Language.english.name == language.name) {
            //         value.changeLanguage(const Locale('en'));
            //       } else {
            //         value.changeLanguage(const Locale('bn'));
            //       }
            //     },
            //     items: <String>['A', 'B', 'C', 'D'].map((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList(),
            //     onChanged: (_) {},
            //   );
            // })
          ],
        ),
      ),
    );
  }
}

enum Language { english, bengali }

// enum Flag {

//   final String countryName;
//   final String countryFlag;

//   bd('bd', '🇧🇩'),

//   Flag(th);  

// }
