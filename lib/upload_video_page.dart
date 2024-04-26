import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadVideoPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();
  String gradeLevel = 'Grade 7';
  String course = 'Math';
  File? thumbnailImage;

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      thumbnailImage = File(pickedFile.path);
    }
  }

  void submitData(BuildContext context) async {
    final String apiUrl = 'http://192.168.137.46:3000/upload_content';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['Title'] = titleController.text;
    request.fields['Description'] = descriptionController.text;
    request.fields['urlLink'] = videoUrlController.text;
    request.fields['gradeLevel'] = request.fields['gradeLevel'] =
        mapGradeLevelToNumber(gradeLevel)
            .toString(); // Map grade level to number
    request.fields['Course'] = course;
    if (thumbnailImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', thumbnailImage!.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Video information uploaded successfully!');
    } else {
      print('Failed to upload video information.');
    }
  }

  String mapGradeLevelToNumber(String gradeLevel) {
    switch (gradeLevel) {
      case 'Grade 7':
        return '7';
      case 'Grade 8':
        return '8';
      default:
        return '7'; // Default to Grade 7 if unknown grade level
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video Information'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Video Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Video Description'),
              ),
              TextField(
                controller: videoUrlController,
                decoration: InputDecoration(labelText: 'Video URL'),
              ),
              DropdownButtonFormField<String>(
                value: gradeLevel,
                onChanged: (String? newValue) {
                  gradeLevel = newValue!;
                },
                items: <String>['Grade 7', 'Grade 8'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Grade Level'),
              ),
              DropdownButtonFormField<String>(
                value: course,
                onChanged: (String? newValue) {
                  course = newValue!;
                },
                items: <String>[
                  'Math',
                  'English',
                  'Science',
                  'Amharic',
                  'Social Science',
                  'Civics'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Course'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _selectImage,
                child: Text('Select Image'),
              ),
              if (thumbnailImage != null) ...[
                SizedBox(height: 16.0),
                Image.file(thumbnailImage!),
              ],
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  submitData(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
