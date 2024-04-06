
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_provider.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumberListProvider>(
      builder: (context, value, child) => Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.numbers.length,
                  itemBuilder: (context, index) {
                    return Text(
                      value.numbers[index].toString(),
                      style: const TextStyle(fontSize: 30),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
