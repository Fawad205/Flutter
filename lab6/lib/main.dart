import 'package:flutter/material.dart';
import 'package:lab6/uiDesign/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme App'),
          actions: [
            Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.all(5)),
            Card(
              child: Text(
              "Flutter is Google's open-source UI "
              "software development kit (SDK) used "
              "to build natively compiled applications "
              "for mobile, web, desktop and embedded "
              "devices from a single codebase.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: myTextStyle18(),
              ),
            ),
            Card(
              child: Text(
                 "Dart is the programming language that powers Flutter."
               "It is a client-optimized, open-source, object-oriented language developed by Google,"
               "specifically designed for building fast, high-quality applications across "
               "multiple platforms (mobile, web, and desktop) from a single codebase  ",
              style: myTextStyle1().copyWith(color: Colors.amberAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
