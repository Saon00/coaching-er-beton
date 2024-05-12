import 'package:coachingerbeton/models/data/student_infoo_sp.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/debitcredit.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/drawer.dart';
import 'package:coachingerbeton/views/pages/students/student_information.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // String dateTime() {
  //  return DateFormat.MMMM().format(DateTime.now());
  // }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // getStudentInfoPref();
    print('Name: ${StudentInfoUtils.displayName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: const MyDrawer(),

      appBar: AppBar(
        // profile name
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Hi, ${StudentInfoUtils.displayName ?? "kire"}',
              style: titlePopins.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),

      // body
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // month name
            Center(
              child: Text(DateFormat('d MMMM ').format(DateTime.now()),
                  style: titlePopins.copyWith(fontSize: 30)),
            ),
            const SizedBox(height: 15),

            // money flow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DebitCreditWidget(
                  title: AppLocalizations.of(context)!.paid.toString(),
                  color: Colors.green,
                  amount: 2000,
                ),
                DebitCreditWidget(
                  title: AppLocalizations.of(context)!.unpaid.toString(),
                  color: Colors.redAccent,
                  amount: 2000,
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StudentInformationPage()));
                },
                child: const Text('next')),

            Text("${StudentInfoUtils.studentName}"),
            Text("${StudentInfoUtils.studentBatch}"),
            Text("${StudentInfoUtils.studentPhoneNumber}"),
            Text("${StudentInfoUtils.studentAddress}"),
          ],
        ),
      ),
    );
  }
}
