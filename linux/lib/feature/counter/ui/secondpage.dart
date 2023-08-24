import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';

class SecondPage extends StatefulWidget {
  final CounterBloc counterBloc;
  const SecondPage({super.key, required this.counterBloc});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterBloc, CounterState>(
      bloc: widget.counterBloc,
      listenWhen: (previous, current) => current is CounterActionState,
      buildWhen: (previous, current) => current is! CounterActionState,
      listener: (context, state) {
        if (state is CounterNavigateSecondPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(
                counterBloc: widget.counterBloc,
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
            title: const Text("FirstPage"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.counterBloc.count.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.counterBloc.add(
                      CounterIncrementEvent(),
                    );
                  },
                  child: const Text("Incrememnt"),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.counterBloc.add(
                      CounterDecrementEvent(),
                    );
                  },
                  child: const Text("Decrement"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
