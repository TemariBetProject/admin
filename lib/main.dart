import 'package:flutter/material.dart';
import 'upload_video_page.dart'; // Importing the upload_video_page.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eLearning Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadVideoPage(), // Using UploadVideoPage as the home page
    );
  }
}
