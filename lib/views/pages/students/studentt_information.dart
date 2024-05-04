import 'package:coachingerbeton/views/pages/students/studentwidgets/textformwid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentInformationPage extends StatefulWidget {
  const StudentInformationPage({super.key});

  @override
  State<StudentInformationPage> createState() => _StudentInformationPageState();
}

class _StudentInformationPageState extends State<StudentInformationPage> {
  final GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.studentinformation),
      ),
      body: Form(
          key: key,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // name
                  TextFormWidget(
                    controller: TextEditingController(),
                    hintText: AppLocalizations.of(context)!.name,
                    textInputType: TextInputType.text,
                    fieldValidator: (value) {
                      if (value == null) {
                        return "student's name required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  //class
                  TextFormWidget(
                    controller: TextEditingController(),
                    hintText: AppLocalizations.of(context)!.classname,
                    textInputType: TextInputType.number,
                    fieldValidator: (value) {
                      if (value == null) {
                        return "student's class required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // phone number
                  TextFormWidget(
                    controller: TextEditingController(),
                    hintText: AppLocalizations.of(context)!.phonenumber,
                    textInputType: TextInputType.number,
                    fieldValidator: (value) {
                      if (value == null) {
                        return "student's phone number required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // address
                  TextFormWidget(
                    controller: TextEditingController(),
                    hintText: AppLocalizations.of(context)!.address,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )),
    );
  }
}
