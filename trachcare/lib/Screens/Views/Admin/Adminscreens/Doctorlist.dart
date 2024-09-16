import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trachcare/Api/Apiurl.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/doctordetails.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/utils/Dimention.dart';
import "package:http/http.dart" as http;

class Doctorlist extends StatefulWidget {
  const Doctorlist({super.key});
  @override
  State<Doctorlist> createState() => _DoctorlistState();
}

class _DoctorlistState extends State<Doctorlist> {
  //String selectedPid = "";
  List<Map<String, dynamic>> Doctorlist = [];



  Future fetchData() async {
    final response = await http.get(Uri.parse(DoctorslistUrl)); // Use http://localhost if you're using a real device or emulator IP for Android
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
  @override
  initState() {
    display_list = Doctorlist;
    super.initState();
  }
  void onsearch(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = Doctorlist;
    } else {
      results = Doctorlist
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      display_list = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 255, 215),
      appBar: NormalAppbar(
        Title: "Patients List",height: dn.height(10),
      ),
      body: FutureBuilder(
         future: fetchData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  display_list = data["data"];
                  print(display_list[0]['id']);
         return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 5, bottom:8,),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.15),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))],
                  ),
        
                  child: TextFormField(
                    onChanged: (value) => onsearch(value),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here....",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(Icons.search,size: 25,),
                    ),
                  )
              ),
              //  SizedBox(height: 0,),
              //
              Expanded(
                child:  ListView.builder(
                  itemCount: display_list.length,
                  itemBuilder: (context, index){
                  print(display_list[index]['id']);

                  return Card(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Doctordetails(),),);
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/doctor.png'),
                      ),
                      title: Text(display_list[index]['id'], style:TextStyle(
                        color: Colors.black,
                      )),
                      subtitle:Text(
                        display_list[index]["username"].toString(),
                        style: const TextStyle(fontSize: 12, color:Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  );}
                )
                   
                ),
          
            ],
          ),
        );}}
       else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 12,
                  ),
                );
              }
               return Center(
                child: Text("something went wrong!!!"),
              );

       }
      ), 
    );
  }
}