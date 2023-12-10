import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.grey.shade900,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const CategoryPage(),
    );
  }
}
