import 'package:flutter/material.dart';
import 'package:google_map_app/screens/detail_page.dart';
import 'package:google_map_app/screens/homepage.dart';
import 'package:google_map_app/screens/location.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail page' : (context) => const Detail_Page(),
        'location' : (context) => const Location_Page(),
      },
    ),
  );
}
