import 'package:coachingerbeton/models/data/student_info_sp.dart';
import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/batch_page.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/debitcredit.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/drawer.dart';
import 'package:coachingerbeton/views/pages/students/student_information.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper();
  int totalPaid = 0;
  int totalUnpaid = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTotals();
  }

  Future<void> fetchTotals() async {
    int paid = await db.getTotalSalary(isPaid: 1);
    int unpaid = await db.getTotalSalary(isPaid: 0);
    setState(() {
      totalPaid = paid;
      totalUnpaid = unpaid;
      isLoading = false;
    });
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
              'Hi, ${StudentInfoUtils.displayName ?? ""}',
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
                  amount: totalPaid,
                ),
                DebitCreditWidget(
                  title: AppLocalizations.of(context)!.unpaid.toString(),
                  color: Colors.redAccent,
                  amount: totalUnpaid,
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

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BatchPage()));
                },
                child: const Text('batch page'))
          ],
        ),
      ),
    );
  }
}
