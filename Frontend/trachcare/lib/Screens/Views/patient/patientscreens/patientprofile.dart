import "dart:convert";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:sizer/sizer.dart";
import "package:trachcare/Screens/Views/patient/patientscreens/editprofile.dart";
import "../../../../Api/Apiurl.dart";
import "../../../../Api/DataStore/Datastore.dart";
import "../../../../components/custom_button.dart";
import "../../../../style/colors.dart";
import "../../../../style/utils/Dimention.dart";
import 'package:http/http.dart' as http;
import "../patientScreenmain.dart";
// import 'package:onboarding/utils/profilefield.dart';
class p_ProfilePage extends StatefulWidget {
  
p_ProfilePage( {super.key, });

  @override
  State<p_ProfilePage> createState() => _p_ProfilePageState();
}

class _p_ProfilePageState extends State<p_ProfilePage> {
  
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
  print(Doctor_id);
   var Data ={
    "patient_id":patient_id.toString()
  };
  try {
    final response = await http.post(Uri.parse(getpatientdetialsurl),body: jsonEncode(Data));
    if(response.statusCode ==200){
      var data = jsonDecode(response.body);
      if(data['Status']){
        return data['pateintinfo'];
      }
      else{
        return data['pateintinfo'];
      }
    }
  } catch (e) {
    print(e);
    
  }
}

@override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        
        body: Container(
          child: SingleChildScrollView(
            
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: dn.height(25),
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
                             Navigator.of(context).push(CupertinoPageRoute(
                                        builder: (context) => PatientMainScreen(),));
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
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CupertinoActivityIndicator(radius: 10,),);
            }
                if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                      var data = snapshot.data;
                      usernameController.text = data["username"].toString();
                      doctorRegNoController.text = data['doctor_reg_no'].toString();
                      emailController.text = data['email'].toString();
                       phoneNumberController.text = data['phone_number'].toString();
                       passwordController.text = data['password'].toString();
                       var imagepath = data["image_path"].toString().substring(2);
                       
                       print(data["image_path"]);
                      return 
             SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Center(child: Text("My profile")),
                     SizedBox(height: 20),
                    Center(
                      
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://$ip/Trachcare/$imagepath"),
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
                    // TextFormField(
                    //   controller: doctorRegNoController,
                    //   enabled: false,
                    //   style: GoogleFonts.ibmPlexSans(
                    //         textStyle: TextStyle(
                    //           color: BlackColor,
                    //             fontSize: 13.sp))
                    //             ,
                    //   decoration: InputDecoration(
                    //     labelText: 'Doctor_reg_no',
                    //     labelStyle: TextStyle(color: BlackColor),
                    //     border: const OutlineInputBorder(),
                    //     filled: true,
                    //     fillColor: const Color.fromARGB(255, 255, 255, 255),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
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
                
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: custom_Button(
                            text: "Edit Profile",
                            width: 50,
                            height: 6,
                            button_funcation: () {
                              var data = snapshot.data;
                              String patientId = patient_id; 
                              String imagepath = data["image_path"].toString().substring(2); 
                              String doctorRegNo = data['doctor_reg_no'].toString();
                              String username = data['username'].toString();
                              String email = data['email'].toString();
                              String phoneNumber = data['phone_number'].toString();
                              String password = data['password'].toString();
                              print(imagepath);
                              // Pass the fetched data to AdminEditProfile
                              Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                                  builder: (context) => Editpatientprofile(
                                    patientId: patientId,
                                    imagepath: imagepath,
                                    doctorRegNo: doctorRegNo,
                                    username: username,
                                    email: email,
                                    phoneNumber: phoneNumber,
                                    password: password,
                                  ),
                                ),(route)=>false
                              );
                            },
                            backgroundColor: sucess_color,
                            textcolor: whiteColor,
                            textSize: 9,
                          ),
                          
                        ),
                      )
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
                
                   
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}