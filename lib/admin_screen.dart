import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlLinkController = TextEditingController();

  Future<void> _postVideoDetails() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String urlLink = _urlLinkController.text;

    // Send HTTP request to post video details to backend

    var regBody = {
      'Title': title,
      'Description': description,
      'urlLink': urlLink,
    };

    final response = await http.post(
        Uri.parse('http://192.168.137.46:3000/upload_content'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    if (response.statusCode == 200) {
      // Video details posted successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video details posted successfully')),
      );
    } else {
      // Failed to post video details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post video details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _urlLinkController,
              decoration: InputDecoration(labelText: 'URL Link'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _postVideoDetails,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
