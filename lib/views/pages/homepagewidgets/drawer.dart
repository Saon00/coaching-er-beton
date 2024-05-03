import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/responsive.dart';
import 'package:flutter/material.dart';

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
      
    );
  }
}
