import "dart:convert";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "../../../../Api/Apiurl.dart";
import "../../../../Api/DataStore/Datastore.dart";
import "../../../../components/custom_button.dart";
import "../../../../style/colors.dart";
import "../../../../style/utils/Dimention.dart";
import 'package:http/http.dart' as http;
// import 'package:onboarding/utils/profilefield.dart';
class ProfilePage extends StatefulWidget {
ProfilePage({super.key,});

  get id => Doctor_id;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController usernameController = TextEditingController(text: "");

  final TextEditingController doctorRegNoController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch data when the widget is initialized
  }

  Future<dynamic> fetchDoctorDetails() async {
  final String url = '$ViewdoctordetailsUrl?doctor_id=${widget.id}';
  print('API URL: $url');  // Debugging purpose

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      
      var data = json.decode(response.body);
      return data;
      }
    
    else {
      print('Failed to fetch doctor details');
    }
  } catch (e) {
    print('Error: $e');
  }
}

@override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    color: TitleColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: SafeArea(
                    child: InkWell(
                          onTap:(){
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.chevron_left,color: BlackColor,size: 28.0,),
                        ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 110,
                    left: 30,
                    right: 30,
                    bottom: 0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: loginFormcolor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: FutureBuilder(

        future: fetchDoctorDetails(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  usernameController.text = data["username"].toString();
                  doctorRegNoController.text = data['doctor_reg_no'].toString();
                  emailController.text = data['email'].toString();
                   phoneNumberController.text = data['phone_number'].toString();
                   passwordController.text = data['password'].toString();
                   var imagepath = data["image_path"].toString().substring(3);
                   print(data["image_path"]);
                  return 
         SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        // backgroundColor: Colors.grey[300],
                        backgroundImage: AssetImage('assets/images/doctor.png'),
                        // backgroundImage:NetworkImage("https://$ip/Trachcare/$imagepath"),
                        // child: const Icon(Icons.person, size: 50, color: Colors.blue),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
               TextFormField(
                style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          color: BlackColor,
                            fontSize: 13.sp))
                            ,
                  controller: usernameController,
                  enabled: false,
                  decoration: InputDecoration(
                    focusColor: BlackColor,
                    labelText: 'username',
                    labelStyle: TextStyle(color: BlackColor),
                    border: const OutlineInputBorder
                    (
                      borderSide: BorderSide(color: BlackColor)
                    ),
                    
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: doctorRegNoController,
                  enabled: false,
                  style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          color: BlackColor,
                            fontSize: 13.sp))
                            ,
                  decoration: InputDecoration(
                    labelText: 'Doctor_reg_no',
                    labelStyle: TextStyle(color: BlackColor),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  enabled: false,
                  style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          color: BlackColor,
                            fontSize: 13.sp))
                            ,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    labelStyle: TextStyle(color: BlackColor),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneNumberController,
                  enabled: false,
                  style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          color: BlackColor,
                            fontSize: 13.sp))
                            ,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: BlackColor),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  enabled: false,
                  obscureText: true,
                  style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          color: BlackColor,
                            fontSize: 13.sp))
                            ,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: BlackColor),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
                 );}
              }
      else if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CupertinoActivityIndicator(radius: 10,),);
      }
      return Center(child: Text("Something went Wrong !!!"),);
  }),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 4.h),
            custom_Button(
                text: "Edit Profile",
                width: 60,
                height: 6,
                button_funcation: (){},
                backgroundColor: sucess_color,
                textcolor: whiteColor,
                textSize: 13),
                SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}