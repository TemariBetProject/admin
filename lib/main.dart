import 'package:flutter/material.dart';
import 'admin_screen.dart'; // Import the admin screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminScreen(), // Set the AdminScreen as the home screen
    );
  }
}
