import 'package:coachingerbeton/models/data/student_infoo_sp.dart';
import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/students/studentwidgets/textformwid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentInformationPage extends StatefulWidget {
  const StudentInformationPage({super.key});

  @override
  State<StudentInformationPage> createState() => _StudentInformationPageState();
}

class _StudentInformationPageState extends State<StudentInformationPage> {
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // String value = "";

  // saveStudentInfoPref(String key, String value) async {
  //   SharedPreferences studentInformationDb =
  //       await SharedPreferences.getInstance();
  //   studentInformationDb.setString(key, value);
  // }

  // getStudentInfoPref() async {
  //   SharedPreferences studentInformationDb =
  //       await SharedPreferences.getInstance();
  //   value = studentInformationDb.getString('studentName') ?? "null";
  //   // return value;
  //   setState(() {});
  // }

  // nfo() {
  //   AlertDialog(
  //     title: const Text('Student Info'),
  //     content: Column(
  //       children: [
  //         Text(studentName),
  //         Text(studentClass),
  //         Text(studentPhoneNumber),
  //         Text(studentAddress),
  //       ],
  //     ),
  //     actions: [
  //       TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text("ok"))
  //     ],
  //   );
  // }

  Future<void> _addStudent() async {
    await StudentInfoUtils.saveStudentInfoPref(
        nameController.text.toString().trim(),
        batchController.text.toString().trim(),
        phoneNumberController.text.toString().trim(),
        addressController.text.toString().trim());
  }

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
                    controller: nameController,
                    hintText: AppLocalizations.of(context)!.name,
                    textInputType: TextInputType.text,
                    fieldValidator: (value) {
                      if (value?.isEmpty == true) {
                        return "student's name required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  //class
                  TextFormWidget(
                    controller: batchController,
                    hintText: AppLocalizations.of(context)!.classname,
                    textInputType: TextInputType.number,
                    fieldValidator: (value) {
                      if (value?.isEmpty == true) {
                        return "student's batch required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // phone number
                  TextFormWidget(
                    controller: phoneNumberController,
                    hintText: AppLocalizations.of(context)!.phonenumber,
                    textInputType: TextInputType.number,
                    fieldValidator: (value) {
                      if (value?.isEmpty == true) {
                        return "student's phone number required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // address
                  TextFormWidget(
                    controller: addressController,
                    hintText: AppLocalizations.of(context)!.address,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      // FocusScope.of(context).unfocus();
                      if (key.currentState!.validate()) {
                        _addStudent();

                        print('Name: ${nameController.text.toString()}');

                        print("${StudentInfoUtils.studentName}");
                        print("${StudentInfoUtils.studentBatch}");
                        print("${StudentInfoUtils.studentPhoneNumber}");
                        print("${StudentInfoUtils.studentAddress}");
                      }
                      nameController.clear();
                      batchController.clear();
                      phoneNumberController.clear();
                      addressController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.black),
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: titlePopins,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
