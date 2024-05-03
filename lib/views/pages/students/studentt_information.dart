import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        title: const Text('Student Information'),
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
                    hintText: "name",
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
                    hintText: "class",
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
                    hintText: "phone number",
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
                    hintText: "address",
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

class TextFormWidget extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextInputType textInputType;
  FormFieldValidator? fieldValidator;
  TextFormWidget({
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.fieldValidator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: fieldValidator,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        hintText: hintText,
        hintStyle: titlePopins,
        fillColor: greyColor,
        focusColor: greyColor,
      ),
      cursorColor: greyColor,
    );
  }
}
