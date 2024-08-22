// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medicproject/common.dart';
// import 'package:medicproject/daddpatient2.dart';

// class Register1 extends StatefulWidget {
//   @override
//   _Register1State createState() => _Register1State();
// }

// class _Register1State extends State<Register1> {
//   String username = '';
//   String password = '';
//   String fname = '';
//   String lname = '';
//   String contact = '';
//   String age = '';
//   String gender = '';
//   String height = '';
//   String weight = '';
//   String bg = '';
//   String sdate = '';

//   List<String> options = ['Male', 'Female', 'Other'];
//   String? selectedGender;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Register your Detail',
//                   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20.0),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'UserName'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter username';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       username = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter password';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       password = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'FirstName'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your first name';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       fname = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'LastName'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your last name';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       lname = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Contact'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter contact number';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       contact = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Age'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your age';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       age = value;
//                     });
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: 'Gender'),
//                   value: selectedGender,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedGender = newValue;
//                       gender = selectedGender!;
//                     });
//                   },
//                   items: <String>['Male', 'Female', 'Other']
//                       .map<DropdownMenuItem<String>>(
//                         (String value) => DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         ),
//                       )
//                       .toList(),
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Height'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your height';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       height = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Weight'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your weight';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       weight = value;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Blood Group'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your blood group';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       bg = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // If the form is valid, proceed with registration
//                       sendRegistrationRequest();

//                       print('Username: $username');
//                       print('Password: $password');
//                       print('First Name: $fname');
//                       print('Last Name: $lname');
//                       print('Contact: $contact');
//                       print('Age: $age');
//                       print('Gender: $gender');
//                       print('Height: $height');
//                       print('Weight: $weight');
//                       print('Blood Group: $bg');
//                       print('Selected Gender: $selectedGender');
//                     }
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Register2(username: username),
//                       ),
//                     );
//                   },
//                   child: Text('Next'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void sendRegistrationRequest() async {
//     var url = Uri.parse(addpatient1uri);
//     var response = await http.post(url, body: {
//       'username': username,
//       'password': password,
//       "firstname": fname,
//       "lastname": lname,
//       "contact": contact,
//       "age": age,
//       "gender": gender,
//       "height": height,
//       "weight": weight,
//       "bloodgroup": bg,
//       "sdate": sdate,
//     });
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//     try {
//       if (response.statusCode == 500) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Login successful'),
//         ));
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => DHomePage()),
//         // );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Login failed'),
//         ));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error parsing JSON'),
//       ));
//     }
//   }
// }