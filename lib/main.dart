import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pax/home.dart';

void main() => runApp(const MyApp()); // inja ro bayad homepage bzarim

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor primaryBlack = const MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PaX",
      theme: ThemeData(
        textTheme:
            GoogleFonts.merriweatherTextTheme(Theme.of(context).textTheme),
        primarySwatch: primaryBlack,
        primaryColor: Colors.black,
      ),
      home: const Home(),
    );
  }
}
