import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../counter_provider.dart';
import 'secondary.dart';

class Home extends StatefulWidget {
  const  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                counterProvider.number.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 56,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondaryPage(
                          number: counterProvider.number,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Navigate",
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            SizedBox(
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
            
              SizedBox(
                height: 16,
              ),
            SizedBox(
              height: 56,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  counterProvider.reset();
                },
                child: const Text(
                  "Reset",
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
