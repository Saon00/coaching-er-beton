import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
              Text(DateFormat.MMMM().format(DateTime.now()), style: titlePopins.copyWith(fontSize: 30)),
              SizedBox(height: 15),
              // money flow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height(context) * .15,
                    width: width(context) * .45,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Debit",
                                style: titlePopins.copyWith(fontSize: 30)),
                            const SizedBox(height: 5),
                            Text('2000 Tk',
                                style: titlePopins.copyWith(fontSize: 30)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: height(context) * .15,
                    width: width(context) * .45,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Credit",
                                style: titlePopins.copyWith(fontSize: 30)),
                            const SizedBox(height: 5),
                            Text('2000 Tk',
                                style: titlePopins.copyWith(fontSize: 30)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
