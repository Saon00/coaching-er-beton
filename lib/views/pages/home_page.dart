import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/debitcredit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: const Drawer(),

      appBar: AppBar(
        backgroundColor: primaryColor,
        // profile name
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Hi, Saon Sikder',
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DebitCreditWidget(
                  title: 'প্রাপ্ত',
                  color: Colors.green,
                  amount: 2000,
                ),
                DebitCreditWidget(
                  title: 'বাকি',
                  color: Colors.redAccent,
                  amount: 2000,
                ),
              ],
            ),
            const SizedBox(height: 15),

            // chart
            // BarChart(
            //   BarChartData(
            //
            //   )
            // )
          ],
        ),
      ),
    );
  }
}
