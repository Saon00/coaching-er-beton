import 'package:coachingerbeton/models/data/student_info_sp.dart';
import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/components/snackbar_msg.dart';
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
        batchController.text.toString().trim().toUpperCase(),
        phoneNumberController.text.toString().trim(),
        addressController.text.toString().trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.studentinformation,
            style: titlePopins.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                        return AppLocalizations.of(context)!
                            .studentnamerequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  //class

                  TextFormWidget(
                    controller: batchController,
                    hintText: AppLocalizations.of(context)!.classname,
                    textInputType: TextInputType.text,
                    fieldValidator: (value) {
                      if (value?.isEmpty == true) {
                        return AppLocalizations.of(context)!
                            .studentclassrequired;
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
                        return AppLocalizations.of(context)!
                            .studentphonenumberrequired;
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
                        showSnackBarMessage(context,
                            AppLocalizations.of(context)!.successfullyadded);
                      }
                      nameController.clear();
                      batchController.clear();
                      phoneNumberController.clear();
                      addressController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor.withOpacity(0.8),
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
