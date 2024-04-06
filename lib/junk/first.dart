
import 'package:coachingerbeton/junk/second.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_provider.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  // List numbers = [1, 2, 3, 4];

  // void add() {
  //   setState(() {
  //     numbers.add(numbers.last + 1);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<NumberListProvider>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  value.numbers.last.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: value.numbers.length,
                      itemBuilder: (context, index) {
                        return Text(
                          value.numbers[index].toString(),
                          style: const TextStyle(fontSize: 30),
                        );
                      }),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Second()));
                    },
                    child: const Text("NExt Page"))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              value.add();
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
