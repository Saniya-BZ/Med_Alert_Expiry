//
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:intl/intl.dart';
class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}): super(key : key);


  @override
  MyScreenState createState()=> MyScreenState();
}
class MyScreenState extends State<MyScreen>{
  // int daysUntilExpiration = 0;
  DateTime currentDate = DateTime.now();
  final CollectionReference _cruddetails = FirebaseFirestore.instance.collection('cruddetails');
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
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
      floatingActionButton: FloatingActionButton(

          onPressed: () {
            _create();
          },
          backgroundColor: Colors.greenAccent,
          child:
          const Icon(Icons.add)

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
          stream: _cruddetails.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShot){
            if(streamSnapShot.hasData){
              return ListView.builder(
                  itemCount: streamSnapShot.data!.docs.length,
                  itemBuilder: (context,index){
                    final DocumentSnapshot documentSnapshot= streamSnapShot.data!.docs[index];
                    return  Container(
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/img_hex_green.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            // child: Text(
                            //   'Medicine Name',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding:  EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(

                                  title: Text(documentSnapshot['name'], style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20),),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Expiry Date: ${DateFormat.yMd().format(documentSnapshot['date'].toDate())}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      // if (_pickedImages[index] != null)
                                      //   Container(
                                      //     margin: EdgeInsets.only(top: 8),
                                      //     child: Image.file(_pickedImages[index]!),
                                      //   ),
                                    ],
                                  ),
                                  leading: _pickedImages[index] != null
                                      ? Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Image.file(_pickedImages[index]!),
                                  ): Text(" "),



                                  trailing: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: IconButton(
                                      onPressed: () {
                                        _captureImage(index);
                                      },
                                      icon: Icon(Icons.camera_alt,),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Divider(
                                    thickness: 1,
                                    height: 20,
                                  ),

                                ),



                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () {
                                            _selectDate(context);
                                          },
                                        ),
                                        SizedBox(width: 5),
                                        Text('Selected Date: ${DateFormat.yMd().format(_selectedDate)}'
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '10:20',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        // DateTime currentDate = DateTime.now();
                                        // int daysUntilExpiration = max(0, _selectedDate.difference(currentDate).inDays);


                                        //     Text(
                                        //   '$daysUntilExpiration days',
                                        //   style: TextStyle(
                                        //     color: Colors.black54,
                                        //   ),
                                        // ),
                                        // Text(
                                        //   daysUntilExpiration > 0
                                        //       ? '$daysUntilExpiration days'
                                        //       : 'Expired',
                                        //   style: TextStyle(
                                        //     color: Colors.black54,
                                        //   ),
                                        // ),
                                        Text(
                                              () {
                                            int daysUntilExpiration = _selectedDate.isAfter(currentDate)
                                                ? _selectedDate.difference(currentDate).inDays
                                                : 0;

                                            return daysUntilExpiration > 0
                                                ? '$daysUntilExpiration days'
                                                : 'Expired';
                                          }(),
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        _update(documentSnapshot);
                                      },
                                      child: Container(
                                        width: 150,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        _delete(documentSnapshot.id);
                                      },
                                      child: Container(
                                        width: 150,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15,)
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                        ],
                      ),
                    );
                  }
              );

            }
            return const Center(
              child: CircularProgressIndicator(),
            ) ;
          }
      ),
    );
  }
  Future<void> _captureImage(int index) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImages[index] = File(pickedImage.path);
      });
    }
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
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
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
                  Text('Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
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
                    Navigator.pop(context); // Close the bottom sheet after updating
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
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
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
                  Text('Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
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
                    await _cruddetails.add({"name": name, "date": _selectedDate});
                    _nameController.text = '';
                    Navigator.pop(context); // Close the bottom sheet after creating
                  }

                  DateTime scheduledDate = DateTime.now().add(Duration(seconds: 1));
                  DateTime currentDate = DateTime.now();
                  int daysUntilExpiration = max(0, _selectedDate.difference(currentDate).inDays);
                  //  daysUntilExpiration = max(0, _selectedDate.difference(currentDate).inDays);
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
                      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
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
}




// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'home_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'dart:math';
// import 'package:intl/intl.dart';
//
// class MyScreen extends StatefulWidget {
//   const MyScreen({Key? key}) : super(key: key);
//
//   @override
//   MyScreenState createState() => MyScreenState();
// }
//
// class MyScreenState extends State<MyScreen> {
//   DateTime currentDate = DateTime.now();
//   final CollectionReference _cruddetails =
//   FirebaseFirestore.instance.collection('cruddetails');
//   final TextEditingController _nameController = TextEditingController();
//   DateTime _selectedDate = DateTime.now();
//   List<File?> _pickedImages = List.filled(100, null);
//   final TextEditingController _controller = TextEditingController();
//   final List<String> _wordSuggestions = ['dolo','paracetemol','montex','Zestril','Synthroid','Lipitor','Gluophage,','Zocor'];
//
//
//
//   @override
//   void initState() {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//       onNotificationCreatedMethod:
//       NotificationController.onNotificationCreatedMethod,
//       onNotificationDisplayedMethod:
//       NotificationController.onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod:
//       NotificationController.onDismissActionReceivedMethod,
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _create();
//         },
//         backgroundColor: Colors.greenAccent,
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: StreamBuilder(
//         stream: _cruddetails.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
//           if (streamSnapShot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapShot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                 streamSnapShot.data!.docs[index];
//                 return Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/img_hex_green.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                       ),
//                       const SizedBox(height: 15),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 4,
//                               spreadRadius: 2,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 documentSnapshot['name'],
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Expiry Date: ${DateFormat.yMd().format(documentSnapshot['date'].toDate())}',
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                 ],
//                               ),
//                               leading: _pickedImages[index] != null
//                                   ? Container(
//                                 margin: EdgeInsets.only(top: 8),
//                                 child: Image.file(_pickedImages[index]!),
//                               )
//                                   : Text(" "),
//                               trailing: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 25,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     _captureImage(index);
//                                   },
//                                   icon: Icon(Icons.camera_alt),
//                                 ),
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 15),
//                               child: Divider(
//                                 thickness: 1,
//                                 height: 20,
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () {
//                                         _selectDate(context);
//                                       },
//                                     ),
//                                     Text('Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
//                                   ],
//                                 ),
//                                 const Row(
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_filled,
//                                       color: Colors.black54,
//                                     ),
//                                     SizedBox(width: 5),
//                                     Text(
//                                       '10:20',
//                                       style: TextStyle(
//                                         color: Colors.black54,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(5),
//                                       decoration: const BoxDecoration(
//                                         color: Colors.green,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Text(
//                                           () {
//                                         int daysUntilExpiration =
//                                         _selectedDate.isAfter(currentDate)
//                                             ? _selectedDate
//                                             .difference(currentDate)
//                                             .inDays
//                                             : 0;
//
//                                         return daysUntilExpiration > 0
//                                             ? '$daysUntilExpiration days'
//                                             : 'Expired';
//                                       }(),
//                                       style: TextStyle(
//                                         color: Colors.black54,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 15,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     _update(documentSnapshot);
//                                   },
//                                   child: Container(
//                                     width: 150,
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 12),
//                                     decoration: BoxDecoration(
//                                         color: Colors.greenAccent,
//                                         borderRadius: BorderRadius.circular(10)),
//                                     child: const Center(
//                                       child: Text(
//                                         "Edit",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     _delete(documentSnapshot.id);
//                                   },
//                                   child: Container(
//                                     width: 150,
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 12),
//                                     decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         borderRadius: BorderRadius.circular(10)),
//                                     child: const Center(
//                                       child: Text(
//                                         "Delete",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 15)
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> _captureImage(int index) async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _pickedImages[index] = File(pickedImage.path);
//       });
//     }
//   }
//
//   Future<void> _update(DocumentSnapshot<Object?> documentSnapshot) async {
//     if (documentSnapshot != null) {
//       _nameController.text = documentSnapshot['name'];
//       _selectedDate = documentSnapshot['date'].toDate();
//     }
//     await showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext ctx) {
//         return Padding(
//           padding: EdgeInsets.only(
//             top: 20,
//             left: 20,
//             right: 20,
//             bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text('Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
//                   IconButton(
//                     icon: const Icon(Icons.calendar_today),
//                     onPressed: () {
//                       _selectDate(context);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   final String name = _nameController.text;
//                   if (name.isNotEmpty) {
//                     await _cruddetails.doc(documentSnapshot.id).update({
//                       "name": name,
//                       "date": _selectedDate,
//                     });
//                     _nameController.text = '';
//                     Navigator.pop(context); // Close the bottom sheet after updating
//                   }
//                 },
//                 child: const Text("Update"),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _create() async {
//     await showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext ctx) {
//         return Padding(
//           padding: EdgeInsets.only(
//             top: 20,
//             left: 20,
//             right: 20,
//             bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // DropdownButton<String>(
//               //   value: selectedMedicine,
//               //   onChanged: (String? newValue) {
//               //     if (newValue != null) {
//               //       setState(() {
//               //         selectedMedicine = newValue;
//               //       });
//               //     }
//               //   },
//               //   items: medicineList.map<DropdownMenuItem<String>>((String value) {
//               //     return DropdownMenuItem<String>(
//               //       value: value,
//               //       child: Text(value),
//               //     );
//               //   }).toList(),
//               // )
//
//               // TextField(
//               //   controller: _controller,
//               //   decoration: InputDecoration(labelText: 'Type something'),
//               // ),
//               SizedBox(height: 16.0),
//               Autocomplete<String>(
//                 optionsBuilder: (TextEditingValue textEditingValue) {
//                   return _wordSuggestions
//                       .where((word) => word.contains(textEditingValue.text.toLowerCase()))
//                       .toList();
//                 },
//                 onSelected: (String selectedWord) {
//                   _controller.text = selectedWord;
//                 },
//               ),
//
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text('Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
//                   IconButton(
//                     icon: const Icon(Icons.calendar_today),
//                     onPressed: () {
//                       _selectDate(context);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   final String name = '';
//                   if (name.isNotEmpty) {
//                     await _cruddetails.add({"name": name, "date": _selectedDate});
//                     _nameController.text = '';
//                     Navigator.pop(context); // Close the bottom sheet after creating
//                   }
//
//                   DateTime scheduledDate = DateTime.now().add(Duration(seconds: 1));
//                   DateTime currentDate = DateTime.now();
//                   int daysUntilExpiration = max(0, _selectedDate.difference(currentDate).inDays);
//
//                   String expirationMessage;
//
//                   if (_selectedDate.isAtSameMomentAs(currentDate)) {
//                     expirationMessage = "Today";
//                   } else if (_selectedDate.isAfter(currentDate)) {
//                     expirationMessage = "$daysUntilExpiration days from now";
//                   } else {
//                     expirationMessage = "Expired";
//                   }
//
//                   await AwesomeNotifications().createNotification(
//                     content: NotificationContent(
//                       id: 1,
//                       channelKey: "basic_channel",
//                       title: "Medical Alert!! ",
//                       body: "$name will expire on $_selectedDate. $expirationMessage",
//                     ),
//                     schedule: NotificationInterval(
//                       interval: 5,
//                       repeats: false,
//                       timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//                     ),
//                   );
//                 },
//                 child: const Text("Create"),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _delete(String productId) async {
//     await _cruddetails.doc(productId).delete();
//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("You have deleted")));
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
// }
//
//














































