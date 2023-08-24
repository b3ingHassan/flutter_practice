import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';
import 'secondpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final CounterBloc counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterBloc, CounterState>(
      bloc: counterBloc,
      listenWhen: (previous, current) => current is CounterActionState,
      buildWhen: (previous, current) => current is! CounterActionState,
      listener: (context, state) {
        if (state is CounterNavigateSecondPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(
                counterBloc: counterBloc,
              ),
            ),
          );
        } else if (state is CounterIncrementActionState ||
            state is CounterDecremenActiontState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("FirstPage"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  counterBloc.count.toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterNavigateSecondPage(),
                    );
                  },
                  child: Text("Navigate"),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterIncrementEvent(),
                    );
                  },
                  child: Text("Incrememnt"),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterDecrementEvent(),
                    );
                  },
                  child: Text("Decrement"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
