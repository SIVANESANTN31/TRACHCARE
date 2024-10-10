import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/ViewPatientDetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';
import "package:http/http.dart" as http;

import '../Bottomnavigator/Admindb.dart';

class patients_list extends StatefulWidget {

   patients_list({super.key});

  @override
  State<patients_list> createState() => _patients_listState();
}

class _patients_listState extends State<patients_list> {
  //String selectedPid = "";
  final List<dynamic> patientslist = [];


  Future fetchData() async {
    final String url = allpatientslistUrl;
    final response = await http.get(Uri.parse(url)); // Use http://localhost if you're using a real device or emulator IP for Android
    if (response.statusCode == 200) {
      // setState(() {
      //   Doctorlist = json.decode(response.body);
      // });
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
    display_list = patientslist;
    super.initState();
  }
  List  onsearch(String enteredKeyword,List data) {
     if (enteredKeyword.isEmpty) return data;
    return data.where((item) => 
    item["username"].toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: NormalAppbar(
        Title: "Patients List",height: dn.height(10), onTap:() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Admindb(),
          ));
        },
      ),
      body:Column(
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
         SizedBox(height: dn.height(1),),
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
                         color: const Color.fromARGB(255, 252, 236, 223),
                         elevation: 4,
                         margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                         child: ListTile(
                           onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) =>  ViewPatientDetails(
                              patientId: filterd_list[index]['patient_id'].toString(), 
                              // patientId: display_list[index]['patient_id'],  // Pass the patient ID
                             
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
                           
                           subtitle:Text(filterd_list[index]['patient_id'], style:const TextStyle(
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
                   return const Center(
                    child: Text("something went wrong!!!"),
                  );
          
           }
          ),
      ],),
    );
  }
}

