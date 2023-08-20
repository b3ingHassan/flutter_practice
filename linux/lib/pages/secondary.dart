import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../counter_provider.dart';

class SecondaryPage extends StatefulWidget {
  final int number;

  const SecondaryPage({super.key, required this.number});

  @override
  State<SecondaryPage> createState() => _SecondaryPageState();
}

class _SecondaryPageState extends State<SecondaryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //  increment();
            counterProvider.increment();
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: const Text("Page 1"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              counterProvider.number.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),SizedBox(
              height: 56,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  counterProvider.decrement();
                },
                child: const Text(
                  "Descrement",
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
