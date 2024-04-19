import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/components/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'homepagewidgets/debitcredit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: Drawer(),

      appBar: AppBar(
        backgroundColor: Colors.yellow,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // month name
              Text(DateFormat.MMMM().format(DateTime.now()),
                  style: titlePopins.copyWith(fontSize: 30)),
              const SizedBox(height: 15),

              // money flow
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DebitCreditWidget(
                    title: 'Debit',
                    color: Colors.green,
                    amount: 2000,
                  ),
                  DebitCreditWidget(
                    title: 'Credit',
                    color: Colors.redAccent,
                    amount: 2000,
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // chart
              BarChart(
                BarChartData(
                  
                )
              )

            ],
          ),
        ),
      ),
    );
  }
}
