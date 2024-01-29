
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> settingsOptions = [
    "Receive notification at",
    "Date format",
    "Delete expired products after",
    "Notify me before expiration date",
  ];

  String selectedNotificationTime = "12:00";
  String selectedDateFormat = "Day/Month/Year";
  int deleteAfterDays = 1;
//  String notifyBeforeExpiration = "Expiring Day";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Settings"),
      //   backgroundColor: Colors.blue,
      // ),
      body: ListView.separated(
        itemCount: 4,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Colors.grey),
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: Row(
                children: [
                  const Text("Receive Notification At"),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      await _showTimePickerDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(selectedNotificationTime),
                    ),
                  ),
                ],
              ),
            );
          } else if (index == 1) {
            return ListTile(
              title: Row(
                children: [
                  const Text("Date format"),
                  const Spacer(),
                  DropdownButton<String>(
                    value: selectedDateFormat,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedDateFormat = newValue;
                        });
                      }
                    },
                    items: ["Day/Month/Year", "Month/Day/Year"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Radio<String>(
                              value: value,
                              groupValue: selectedDateFormat,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDateFormat = newValue!;
                                });
                              },
                            ),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else if (index == 2) {
            return ListTile(
              title: Row(
                children: [
                  const Text("Delete expired products after"),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: DropdownButton<int>(
                      value: deleteAfterDays,
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            deleteAfterDays = newValue;
                          });
                        }
                      },
                      items: List.generate(30, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          // } else if (index == 3) {
          //   return ListTile(
          //     title: Row(
          //       children: [
          //         const Text("Notify me before expiration date"),
          //         const Spacer(),
          //         Container(
          //           padding:const  EdgeInsets.all(6.0),
          //           decoration: BoxDecoration(
          //             border: Border.all(color: Colors.grey),
          //             borderRadius: BorderRadius.circular(3.0),
          //           ),
          //           child: DropdownButton<String>(
          //             value: notifyBeforeExpiration,
          //             onChanged: (String? newValue) {
          //               if (newValue != null) {
          //                 setState(() {
          //                   notifyBeforeExpiration = newValue;
          //                 });
          //               }
          //             },
          //             items: [
          //               "Expiring Day",
          //               "1 Day",
          //               "2 Days",
          //               "3 Days",
          //               "1 Week",
          //               "2 Weeks",
          //               "1 Month",
          //               "2 Months",
          //               "3 Months"
          //             ].map<DropdownMenuItem<String>>((String value) {
          //               return DropdownMenuItem<String>(
          //                 value: value,
          //                 child: RadioListTile<String>(
          //                   title: Text(value),
          //                   value: value,
          //                   groupValue: notifyBeforeExpiration,
          //                   onChanged: (String? newValue) {
          //                     setState(() {
          //                       notifyBeforeExpiration = newValue!;
          //                     });
          //                   },
          //                 ),
          //               );
          //             }).toList(),
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          }
          return Container(); // Return an empty container for other indices
        },
      ),
    );
  }

  Future<void> _showTimePickerDialog(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (selectedTime != null) {
      setState(() {
        selectedNotificationTime = "${selectedTime.hour}:${selectedTime.minute}";
      });
    }
  }
}

