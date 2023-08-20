import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_provider.dart';
import 'pages/home.dart';
import 'utils/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterProvider>(
          create: (context) => CounterProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Appcolors.primaryColor),
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Appcolors.primaryColor),
            appBarTheme: AppBarTheme(backgroundColor: Appcolors.primaryColor),
            primaryColor: Appcolors.primaryColor),
        home: const Home(),
      ),
    );
  }
}
