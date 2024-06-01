import 'package:coachingerbeton/controllers/themecontroller.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/batch_page.dart';
import 'package:coachingerbeton/views/pages/home_page.dart';
import 'package:coachingerbeton/views/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _selectPage = 0;

  final List<Widget> _index = [
    const HomePage(),
    const BatchPage(),
    const SettingsPage()
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _index[_selectPage],
      bottomNavigationBar: Container(
        // color: Colors.yellow.shade100,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: GNav(
          color: Colors.grey.shade400,
          activeColor: Colors.grey.shade700,
          mainAxisAlignment: MainAxisAlignment.center,
          // tabActiveBorder: Border.all(color: Colors.black),
          tabBackgroundColor: Provider.of<ThemeContoller>(context).isDark
              ? Colors.white
              : Colors.black,
          // backgroundColor: Colors.yellow.shade100,
          tabBorderRadius: 16,
          gap: 3,
          textStyle: titlePopins,
          onTabChange: (index) => navigateBottomBar(index),
          tabs: const [
            GButton(
              icon: Icons.home,
            ),
            GButton(
              icon: Icons.people,
            ),
            GButton(
              icon: Icons.settings,
            ),
          ],
        ),
      ),
    );
  }
}
