import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:trachcare/Api/Apiurl.dart';
import "package:http/http.dart" as http;
import 'package:trachcare/Screens/Views/Doctor/doctorscreens/DailyUpadtes_patient.dart';


void SubmitDailyVitals(BuildContext context, String patientId, Map<String, dynamic> vitalsData) async {
  try {
    final response = await http.post(
      Uri.parse(SubmitVitalsUrl), // Assuming you pass patientId in the URL
      body: jsonEncode(vitalsData),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["Status"]) {
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message']} 🎉'),
          showProgressBar: false,
          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
          showIcon: true,
          autoCloseDuration: const Duration(seconds: 2),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DailyUpdatePatients()),
        );
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message']}'),
          icon: const Icon(Icons.cancel_rounded, color: Colors.red),
          showIcon: true,
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  } catch (e) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context,
      title: Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded, color: Colors.red),
      showIcon: true,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}




void ViewDailyVitals(BuildContext context, String patientId, String date) async {
  try {
    final response = await http.get(
      Uri.parse(ViewDailyVitalsUrl), // Assuming patientId and date are passed in the URL
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["Status"]) {
        // Display the daily vitals in a dialog or new page
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Daily Vitals for ${data['userInfo']['name']}'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Date: ${data['userInfo']['date']}'),
                    Text('Name: ${data['userInfo']['name']}'),
                    Text('Patient ID: ${data['userInfo']['patient_id']}'),
                    Text('Vitals:'),
                    Text(' - Respiratory Rate: ${data['userInfo']['vitals']['respiratory_rate']}'),
                    Text(' - Heart Rate: ${data['userInfo']['vitals']['heart_rate']}'),
                    Text(' - SPO2 @ Room Air: ${data['userInfo']['vitals']['spo2_room_air']}'),
                    Text('Daily dressing done: ${data['userInfo']['daily_dressing_done']}'),
                    Text('Tracheostomy tie changed: ${data['userInfo']['tracheostomy_tie_changed']}'),
                    Text('Suctioning done: ${data['userInfo']['suctioning_done']}'),
                    Text('Oral feeds started: ${data['userInfo']['oral_feeds_started']}'),
                    Text('Changed to green tube: ${data['userInfo']['changed_to_green_tube']}'),
                    Text('Spigotting Status:'),
                    Text(' - Able to breathe through nose: ${data['userInfo']['spigotting_status']['breathing_through_nose']}'),
                    if (data['userInfo']['spigotting_status']['breathing_through_nose'] == "Yes")
                      Text(' - Breath Duration: ${data['userInfo']['spigotting_status']['breath_duration']}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message']}'),
          icon: const Icon(Icons.cancel_rounded, color: Colors.red),
          showIcon: true,
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  } catch (e) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context,
      title: Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(Icons.cancel_rounded, color: Colors.red),
      showIcon: true,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}





  // Function to fetch and display vitals
  void fetchAndDisplayVitals(BuildContext context, String patientId, String date) async {
    // Call your backend API to fetch the daily vitals for the selected date
    try {
      final response = await http.get(
        Uri.parse('$ViewDailyVitalsUrl/$patientId/$date'), // Backend URL
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["Status"]) {
          // Show the vitals in a dialog or navigate to another screen
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Vitals for $date'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Respiratory Rate: ${data['vitals']['respiratory_rate']}'),
                      Text('Heart Rate: ${data['vitals']['heart_rate']}'),
                      Text('SPO2 @ Room Air: ${data['vitals']['spo2_room_air']}'),
                      Text('Daily dressing done: ${data['status']['daily_dressing_done']}'),
                      Text('Tracheostomy tie changed: ${data['status']['tracheostomy_tie_changed']}'),
                      Text('Suctioning done: ${data['status']['suctioning_done']}'),
                      Text('Oral feeds started: ${data['status']['oral_feeds_started']}'),
                      Text('Changed to green tube: ${data['status']['changed_to_green_tube']}'),
                      Text('Spigotting status: ${data['spigotting_status']['breathing_through_nose']}'),
                      if (data['spigotting_status']['breathing_through_nose'] == "Yes")
                        Text('Breath Duration: ${data['spigotting_status']['breath_duration']}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          toastification.show(
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            context: context,
            title: Text('${data['message']}'),
            icon: const Icon(Icons.cancel_rounded, color: Colors.red),
            showIcon: true,
            showProgressBar: false,
            autoCloseDuration: const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        context: context,
        title: Text('Something went wrong'),
        showProgressBar: false,
        icon: const Icon(Icons.cancel_rounded, color: Colors.red),
        showIcon: true,
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  }
