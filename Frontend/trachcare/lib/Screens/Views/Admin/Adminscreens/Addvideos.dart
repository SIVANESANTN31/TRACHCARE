import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:toastification/toastification.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/videolist.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';
import '../Bottomnavigator/Admindb.dart';

class VideoUploadPage extends StatefulWidget {
  @override
  _VideoUploadPageState createState() => _VideoUploadPageState();
}

class _VideoUploadPageState extends State<VideoUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _filePath;
  
  String get doctorId => Doctor_id;
  
  String get patientId => patient_id;

  Future<void> _pickFile() async {
    // Validate the form first before allowing file selection
    if (_formKey.currentState!.validate()) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
        });
        print('File path: $_filePath');
      } else {
        print('No file selected');
      }
    } else {
      // Show error message if form validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields before selecting a video file.')),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_filePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a video file')),
        );
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(Addvideos));
      var videoFileName = _filePath;
      request.fields['title'] = _titleController.text;
      request.fields['description'] = _descriptionController.text;
      request.files.add(await http.MultipartFile.fromPath(
        'videoFile',
        videoFileName!,
        filename: path.basename(videoFileName),
      ));

      // Send the request to the server
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Upload success: $responseBody');
        _titleController.clear();
        _descriptionController.clear();
        _filePath = null;

        toastification.show(
          type: ToastificationType.success,
          alignment: Alignment.bottomRight,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('Successfully video uploaded!!!  🎉'),
          showProgressBar: false,
          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
          showIcon: true,
          autoCloseDuration: const Duration(seconds: 2),
        );
      } else {
        print('Upload failed: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(
        Title: "Upload videos",
        height: dn.height(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Admindb(),
          ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: _pickFile,
                child: Text('Select File'),
              ),
              SizedBox(height: 20),
              _filePath != null
                  ? Text(
                      'File Selected ',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 7, 196, 0)),
                    )
                  : Text(
                      'No file selected.',
                      style: TextStyle(color: Colors.red),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: _submitForm,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
