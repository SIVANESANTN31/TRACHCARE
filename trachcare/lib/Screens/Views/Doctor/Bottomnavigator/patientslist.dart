import 'package:flutter/material.dart';

import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../Patientsdetails.dart';

class patientslist extends StatefulWidget {
  const patientslist({super.key});

  @override
  State<patientslist> createState() => _patientslistState();
}

class _patientslistState extends State<patientslist> {
 
  final List<Map<String, dynamic>> patientslist = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];
// This list holds the data for the list view
  List<Map<String, dynamic>> display_list = [];
  @override
  initState() {

    display_list = patientslist;
    super.initState();
  }
 void onsearch(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = patientslist;
    } else {
      results = patientslist
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      display_list = results;
    });
  }

  // onsearch(String search){
  //   setState(() {
  //     display_list = patientslist.where((user) => main_pat.patient_name.Tolo);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 255, 215),
      appBar: NormalAppbar(
        Title: "Patients List",
      ),
      body:Padding(
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
              child: display_list.isNotEmpty
                  ? ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) => Card(
                  color: Color.fromRGBO(180, 249, 183, 1),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    onTap: (){
                      
                    },
                    leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage('assets/images/doctor.png'),
                                  ),
                    title: Text(display_list[index]['name'], style:TextStyle(
                      color: Colors.black87,
                    )),
                    subtitle:Text(
                     display_list[index]["id"].toString(),
                      style: const TextStyle(fontSize: 24, color:Colors.white),
                    ),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}