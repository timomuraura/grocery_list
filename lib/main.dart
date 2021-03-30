import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:grocery_list/screens/homepage.dart';
import 'package:grocery_list/screens/profilepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // remove debug burnner
      debugShowCheckedModeBanner: false,
      // set text them for the entire app
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Profile()
    );
  }
}
