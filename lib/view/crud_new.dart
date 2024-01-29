import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference _cruddetails = FirebaseFirestore.instance
      .collection('cruddetails');
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  //File? _pickedImage;
  // Map<String, File?> _pickedImages = {};
  List<File?> _pickedImages = List.filled(100, null);

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
      NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
      NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
      NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      floatingActionButton: FloatingActionButton(

          onPressed: () {
            _create();
          },
          backgroundColor: Colors.green,
          child:
          const Icon(Icons.add)

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('M E D I C A L    A L E R T !!'),
      ),
      body: StreamBuilder(
        stream: _cruddetails.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
          if (streamSnapShot.hasData) {
            return ListView.builder(
              itemCount: streamSnapShot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapShot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name'], style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),),

                      // subtitle: Text(
                      //   'Expiry Date: ${DateFormat.yMd().format(documentSnapshot['date'].toDate(),)}',style: TextStyle(fontSize: 15),
                      // ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date: ${DateFormat.yMd().format(
                                documentSnapshot['date'].toDate())}',
                            style: TextStyle(fontSize: 15),
                          ),
                          if (_pickedImages[index] != null)
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Image.file(_pickedImages[index]!),
                            ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _update(documentSnapshot);
                              },
                              icon: const Icon(Icons.edit, color: Colors.blue,),
                            ),
                            IconButton(
                              onPressed: () {
                                _delete(documentSnapshot.id);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                            IconButton(
                              onPressed: () {
                                _captureImage(index);
                              },
                              icon: const Icon(
                                  Icons.camera_alt, color: Colors.black),
                            ),
                          ],

                        ),

                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _update(DocumentSnapshot<Object?> documentSnapshot) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _selectedDate = documentSnapshot['date'].toDate();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(ctx)
                .viewInsets
                .bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Selected Date: ${DateFormat.yMd().format(
                      _selectedDate)}'),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  if (name.isNotEmpty) {
                    await _cruddetails.doc(documentSnapshot.id).update({
                      "name": name,
                      "date": _selectedDate,
                    });
                    _nameController.text = '';
                    Navigator.pop(
                        context); // Close the bottom sheet after updating
                  }
                },
                child: const Text("Update"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(ctx)
                .viewInsets
                .bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Selected Date: ${DateFormat.yMd().format(
                      _selectedDate)}'),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  if (name.isNotEmpty) {
                    await _cruddetails.add(
                        {"name": name, "date": _selectedDate});
                    _nameController.text = '';
                    Navigator.pop(
                        context); // Close the bottom sheet after creating
                  }

                  DateTime scheduledDate = DateTime.now().add(
                      Duration(seconds: 1));
                  DateTime currentDate = DateTime.now();
                  int daysUntilExpiration = max(0, _selectedDate
                      .difference(currentDate)
                      .inDays);

                  String expirationMessage;

                  if (_selectedDate.isAtSameMomentAs(currentDate)) {
                    expirationMessage = "Today";
                  } else if (_selectedDate.isAfter(currentDate)) {
                    expirationMessage = "$daysUntilExpiration days from now";
                  } else {
                    // Handle the case where the selected date is in the past
                    expirationMessage = "Expired";
                  }

                  await AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: 1,
                      channelKey: "basic_channel",
                      title: "Medical Alert!! ",
                      body: "$name will expire on $_selectedDate. $expirationMessage",
                    ),
                    schedule: NotificationInterval(
                      interval: 5,
                      repeats: false,
                      //  exact: true,
                      timeZone: await AwesomeNotifications()
                          .getLocalTimeZoneIdentifier(),
                    ),
                  );
                },
                child: const Text("Create"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async {
    await _cruddetails.doc(productId).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("You have deleted")));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _captureImage(int index) async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _pickedImages[index] = File(pickedImage.path);
      });
    }
  }
}
  // Future<void> _captureImage(String documentId) async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //
  //   if (pickedImage != null) {
  //     setState(() {
  //       _pickedImages[documentId] = File(pickedImage.path);
  //     });
  //   }
  // }

  // Future<void> _captureImage() async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //
  //   if (pickedImage != null) {
  //     setState(() {
  //       _pickedImage = File(pickedImage.path);
  //     });
  //   }
  // }












