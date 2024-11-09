import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Screens/Views/Admin/Adminmainpage.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/doctordetails.dart';

import 'package:trachcare/style/colors.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';
import "package:http/http.dart" as http;

class patientlist extends StatefulWidget {
  final String doctor_id;
  patientlist({super.key, required this.doctor_id});
  @override
  State<patientlist> createState() => _patientlistState();
}

class _patientlistState extends State<patientlist> {
  //String selectedPid = "";
  List<dynamic> Doctorlist = [];



  Future fetchData() async {
    var url = "$PatientslistUrl?doctor_id=${widget.doctor_id}";
    print(url);
    final response = await http.get(Uri.parse(url)); // Use http://localhost if you're using a real device or emulator IP for Android
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
// This list holds the data for the list view
  List<dynamic> display_list = [];
  String serachKeyword ="";

  TextEditingController controller = new TextEditingController();
  
  @override
  initState() {
    display_list = Doctorlist;
    super.initState();
  }
  List  onsearch(String enteredKeyword,List data) {
     if (enteredKeyword.isEmpty) return data;
    return data.where((item) => item["username"].toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
 }

Future<void> onRefresh() async{
  await Future.delayed(Duration(milliseconds: 1000));
  await fetchData();
  setState(() {
    
  });
}

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 255, 215),
      appBar: NormalAppbar(Title: "Patients List",height: dn.height(10), onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => Adminmainpage(),),);
      },),
      body: Column(
        children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child:SizedBox(
  height: dn.height(8),
  child: Container(
    decoration: BoxDecoration(
      color: whiteColor, // Background color
      borderRadius: BorderRadius.circular(8), // Rounded corners
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), // Shadow color
          blurRadius: 5, // Spread radius
          offset: Offset(0, 2), // Shadow position
        ),
      ],
    ),
    child: CupertinoSearchTextField(
      backgroundColor: Colors.transparent, // Make the background transparent to show the container's color
      autocorrect: true,
      placeholder: "eg: John",
      controller: controller,
      onChanged: (value) => setState(() => serachKeyword = value),
    ),
  ),
),
         ),
               
          FutureBuilder(
             future: fetchData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List filterd_list = onsearch(serachKeyword, snapshot.data["data"]);
                  
             return  
             
             Expanded(
            
                     child: 
                     
                      ListView.builder(
                       itemCount: filterd_list.length,
                       itemBuilder: (context, index){
                      
                       var image_path = filterd_list[index]['image_path'].toString().substring(2);
                       return Card(
                         color: const Color.fromRGBO(255, 255, 255, 1),
                         elevation: 4,
                         margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                         child: ListTile(
                           onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => Doctordetails(
                                 
                                 Doctor_id:  filterd_list[index]['doctor_id'].toString(), 
                                
                               ),),);
                           },
                           leading:  CircleAvatar(
                             radius: 25,
                             backgroundImage: NetworkImage("https://$ip/Trachcare/$image_path"),
                           ),
                           title: Text(
                             filterd_list[index]["username"].toString(),
                             style: const TextStyle( color:Color.fromARGB(255, 0, 0, 0)),
                           ),
                           
                           subtitle:Text(filterd_list[index]['doctor_id'], style:const TextStyle(
                             color: Colors.black,fontSize: 12,
                           )),
                         ),
                       );}
                     )
                        
                     
               
                 
               
             );}}
           else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 12,
                      ),
                    );
                  }
                 // print(snapshot.hasData);
                   return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.gif', // Change this path if necessary
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          const Text("Something went wrong!!"),
        ],
      ),
    );
          
           }
          ),
        ],
      ), 
    );
  }
}
