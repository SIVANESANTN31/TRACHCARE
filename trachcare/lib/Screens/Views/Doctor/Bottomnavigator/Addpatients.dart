import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/Patientsdetails.dart';

import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';

class Addpatients extends StatefulWidget {
  @override
  _AddpatientsState createState() => _AddpatientsState();
}

class _AddpatientsState extends State<Addpatients> {
  final List<Map<String, dynamic>> patientslist = [
    {"id": 192121051, "name": "Andy", "age": 29},
    {"id": 192121052, "name": "Aragon", "age": 40},
    {"id": 192121053, "name": "Bob", "age": 5},
    {"id": 192121054, "name": "Barbara", "age": 35},
    {"id": 192121055, "name": "Candy", "age": 21},
    {"id": 192121056, "name": "Colin", "age": 55},
    {"id": 192121057, "name": "Audra", "age": 30},
    {"id": 192121058, "name": "Banana", "age": 14},
    {"id": 192121059, "name": "Caversky", "age": 100},
    {"id": 192121060, "name": "Becky", "age": 32},
  ];
// This list holds the data for the list view
  List<Map<String, dynamic>> display_list = [];
  @override
  initState() {

    display_list = patientslist;
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String fname = '';
  String lname = '';
  String contact = '';
  String age = '';
  String gender = '';
  String height = '';
  String weight = '';
  String bg = '';
  String sdate = '';

  List<String> options = ['Male', 'Female', 'Other'];
  String? selectedGender;
  
  get index => null;

  // Future<void> addUser() async {
  //   final response = await http.post(
  //     Uri.parse('http://your-server-url/add_user.php'),
  //     body: {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     if (result['success']) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User added successfully')));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add user')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Server error')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      appBar: NormalAppbar(Title: "Your Daily Update",height: dn.height(10),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register your Detail',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'UserName'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'FirstName'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      fname = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'LastName'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      lname = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contact'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter contact number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Gender'),
                  value: selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                      gender = selectedGender!;
                    });
                  },
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Height'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      height = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Weight'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      weight = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Blood Group'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your blood group';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      bg = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // If the form is valid, proceed with registration
                    //   sendRegistrationRequest();

                    //   print('Username: $username');
                    //   print('Password: $password');
                    //   print('First Name: $fname');
                    //   print('Last Name: $lname');
                    //   print('Contact: $contact');
                    //   print('Age: $age');
                    //   print('Gender: $gender');
                    //   print('Height: $height');
                    //   print('Weight: $weight');
                    //   print('Blood Group: $bg');
                    //   print('Selected Gender: $selectedGender');
                    // }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Patientsdetails(),
                      ),
                    );
                  },
                  child: Text('Next'),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
