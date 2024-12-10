import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:toastification/toastification.dart';
import 'package:trachcare/Api/DataStore/Datastore.dart';
import 'package:trachcare/Screens/Views/Admin/Adminmainpage.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';

class VideoUploadPage extends StatefulWidget {
  @override
  _VideoUploadPageState createState() => _VideoUploadPageState();
}
class _VideoUploadPageState extends State<VideoUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _filePath;
  String? _thumbnailPath;
  bool _isLoading = false;

  String get doctorId => Doctor_id;
  String get patientId => patient_id;

  Future<void> _pickFile() async {
    if (_formKey.currentState!.validate()) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
        });
        print('Video file path: $_filePath');
      } else {
        print('No video file selected');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields before selecting a video file.')),
      );
    }
  }

  Future<void> _pickThumbnail() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _thumbnailPath = result.files.single.path;
      });
      print('Thumbnail path: $_thumbnailPath');
    } else {
      print('No thumbnail selected');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_filePath == null || _thumbnailPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both a video and a thumbnail image.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      var request = http.MultipartRequest('POST', Uri.parse(Addvideos));
      request.fields['title'] = _titleController.text;
      request.fields['description'] = _descriptionController.text;

      // Attach video file
      request.files.add(await http.MultipartFile.fromPath(
        'videoFile',
        _filePath!,
        filename: path.basename(_filePath!),
      ));

      // Attach thumbnail image
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnailImage',
        _thumbnailPath!,
        filename: path.basename(_thumbnailPath!),
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Upload success: $responseBody');
        _formKey.currentState!.reset();
        setState(() {
          _titleController.clear();
          _descriptionController.clear();
          _filePath = null;
          _thumbnailPath = null;
          _isLoading = false;
        });

        toastification.show(
          type: ToastificationType.success,
          alignment: Alignment.bottomRight,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('Successfully uploaded video and thumbnail! 🎉'),
          showProgressBar: false,
          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
          showIcon: true,
          autoCloseDuration: const Duration(seconds: 2),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
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
            builder: (context) => Adminmainpage(),
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
                child: Text('Select Video File'),
              ),
              SizedBox(height: 10),
              _filePath != null
                  ? Text(
                      'Video file selected',
                      style: TextStyle(color: Colors.green),
                    )
                  : Text(
                      'No video file selected.',
                      style: TextStyle(color: Colors.red),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: _pickThumbnail,
                child: Text('Select Thumbnail Image'),
              ),
              SizedBox(height: 10),
              _thumbnailPath != null
                  ? Text(
                      'Thumbnail selected',
                      style: TextStyle(color: Colors.green),
                    )
                  : Text(
                      'No thumbnail selected.',
                      style: TextStyle(color: Colors.red),
                    ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
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
