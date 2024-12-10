import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:excel/excel.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:trachcare/Screens/Views/Admin/Adminmainpage.dart';
import 'package:trachcare/Screens/Views/Admin/Adminscreens/ViewPatientDetails.dart';
import '../../../../Api/Apiurl.dart';
import '../../../../components/NAppbar.dart';
import '../../../../style/colors.dart';
import '../../../../style/utils/Dimention.dart';
import "package:http/http.dart" as http;

class patients_list extends StatefulWidget {

   patients_list({super.key});

  @override
  State<patients_list> createState() => _patients_listState();
}

// Future<void> generateExcel(List<Map<String, dynamic>> patientDetails) async {
//   var excel = Excel.createExcel();
//   var sheet = excel['Patients'];

//   // Add header
//   sheet.appendRow(patientDetails.first.keys.toList());

//   // Add data rows
//   for (var detail in patientDetails) {
//     sheet.appendRow(detail.values.toList());
//   }

//   // Save Excel file
//   final output = await getExternalStorageDirectory();
//   final file = File("${output!.path}/patient_details.xlsx");
//   await file.writeAsBytes(excel.encode()!);
//   print('Excel file saved at ${file.path}');
// }

// Future<void> generatePdf(List<Map<String, dynamic>> patientDetails) async {
//   final pdf = pw.Document();
// print(patientDetails);
//  print("&&&&&&&&&&&&&&");
//   pdf.addPage(
//     pw.Page(
//       build: (context) => pw.Column(
//         children: [
//           pw.Text('Patient Details', style: pw.TextStyle(fontSize: 24)),
//           pw.SizedBox(height: 20),
//           pw.Table.fromTextArray(
//             context: context,
//             data: [
//               patientDetails.first.keys.toList(),
//               ...patientDetails.map((e) => e.values.toList())
//             ],
//           ),
//         ],
//       ),
//     ),
//   );

//   final output = await getExternalStorageDirectory();
//   print(output);
//   final file = File("${output!.path}/patient_details.pdf");
//   await file.writeAsBytes(await pdf.save());
//   print('PDF saved at ${file.path}');
// }


class _patients_listState extends State<patients_list> {
  List<dynamic> patientslist = [];
  List<dynamic> display_list = [];
  String searchKeyword = "";

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String url = allpatientslistUrl;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        patientslist = json.decode(response.body)["data"];
        display_list = patientslist;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> onSearch(String enteredKeyword, List<dynamic> data) {
    if (enteredKeyword.isEmpty) return data;
    return data.where((item) =>
        item["username"].toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }

  Future<void> onRefresh() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 255, 215),
      appBar: NormalAppbar(
        Title: "Patients List",
        height: dn.height(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Adminmainpage(),
          ));
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: dn.height(8),
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                        backgroundColor: Colors.transparent,
                        autocorrect: true,
                        placeholder: "eg: John",
                        controller: controller,
                        onChanged: (value) {
                          setState(() {
                            searchKeyword = value;
                            display_list = onSearch(searchKeyword, patientslist);
                          });
                        },
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: dn.height(1)),
          Expanded(
            child: ListView.builder(
              itemCount: display_list.length,
              itemBuilder: (context, index) {
                var image_path = display_list[index]['image_path'].toString().substring(2);
                return Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewPatientDetails(
                          patientId: display_list[index]['patient_id'].toString(),
                        ),
                      ));
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("https://$ip/Trachcare/$image_path"),
                    ),
                    title: Text(
                      display_list[index]["username"].toString(),
                      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    subtitle: Text(display_list[index]['patient_id'], style: const TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
