// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:image_picker/image_picker.dart';
// import 'home_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math';
// import 'package:intl/intl.dart';
// import 'bottom_nav_bar.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final CollectionReference _cruddetails =
//   FirebaseFirestore.instance.collection('cruddetails');
//   final TextEditingController _nameController = TextEditingController();
//   DateTime _selectedDate = DateTime.now();
//   ImagePicker imageUrl = ImagePicker();
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
//       backgroundColor: Colors.green.shade200,
//       floatingActionButton: FloatingActionButton(
//
//           onPressed: () {
//             _create();
//           },
//           backgroundColor: Colors.green,
//           child:
//           const Icon(Icons.add)
//
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       appBar: AppBar(
//         title: const Text('M E D I C A L    A L E R T !!'),
//       ),
//       body: StreamBuilder(
//         stream: _cruddetails.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
//           if (streamSnapShot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapShot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                 streamSnapShot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: ListTile(
//                       title: Text(documentSnapshot['name'], style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20),),
//
//                       // subtitle: Text(
//                       //   'Expiry Date: ${DateFormat.yMd().format(documentSnapshot['date'].toDate(),)}',style: TextStyle(fontSize: 15),
//                       // ),
//                        subtitle: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                         Text(
//                           'Expiry Date: ${DateFormat.yMd().format(documentSnapshot['date'].toDate())}',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(height: 8),
//                            documentSnapshot['imageUrl'] != null
//                                ? Image.network(documentSnapshot['imageUrl'], height: 100, width: 100) // Adjust the height and width as needed
//                                : Container(),
//
//                       ],
//                     ),
//                       trailing: SizedBox(
//                         width: 150,
//                         child: Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 _update(documentSnapshot);
//                               },
//                               icon: const Icon(Icons.edit),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 _delete(documentSnapshot.id);
//                               },
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                             ),
//                             IconButton(onPressed: (){
//                               _captureImage(documentSnapshot.id);
//                             }, icon: Icon(Icons.camera_alt))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//
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
//   Future<void> _update(DocumentSnapshot<Object?> documentSnapshot) async {
//     if (documentSnapshot != null) {
//       _nameController.text = documentSnapshot['name'];
//       _selectedDate = documentSnapshot['date'].toDate();
//
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
//                       "imageUrl": imageUrl,
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
//   Future<void> _create() async {
//
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
//                     // Handle the case where the selected date is in the past
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
//                       //  exact: true,
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
//
//   // Future<void> _captureImage(String documentId) async {
//   //   final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
//   //
//   //   if (pickedFile != null) {
//   //     File imageFile = File(pickedFile.path);
//   //
//   //     // Upload the image to Firebase Storage
//   //     String imageUrl = await _uploadImageToFirebaseStorage(imageFile);
//   //
//   //     // Update the Firestore document with the image URL
//   //     await _cruddetails.doc(documentId).update({"imageUrl": imageUrl});
//   //   }
//   // }
//   //
//   // Future<String> _uploadImageToFirebaseStorage(File imageFile) async {
//   //   String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//   //   Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
//   //
//   //   UploadTask uploadTask = storageReference.putFile(imageFile);
//   //   await uploadTask.whenComplete(() => print("Image uploaded"));
//   //
//   //   return await storageReference.getDownloadURL();
//   // }
//   Future<void> _captureImage(String documentId) async {
//     final XFile? pickedFile = await imageUrl.pickImage(source: ImageSource.camera);
//
//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);
//
//       // Upload image to Firebase Storage
//       String imagePath = 'images/${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}.png';
//       UploadTask uploadTask = FirebaseStorage.instance.ref().child(imagePath).putFile(imageFile);
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//       String imageUrl = await taskSnapshot.ref.getDownloadURL();
//
//       // Update Firestore with the image URL
//       await _cruddetails.doc(documentId).update({"imageUrl": imageUrl});
//     }
//   }
//
//
//
// }
//
//
//
//
//
//
//
//





//
//
// class ExpiryAlertScreen extends StatefulWidget {
//   @override
//   _ExpiryAlertScreenState createState() => _ExpiryAlertScreenState();
// }
//
// class _ExpiryAlertScreenState extends State<ExpiryAlertScreen> {
//   TextEditingController controller = TextEditingController();
//   List<String> medicines = ['crocin', 'dolo', 'canasa', 'adresomysene', 'meftil'];
//   late DateTime _selectedDate;
//   File? _image;
//
//
//   Future<void> _getImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Column(
//           children: [
//             GestureDetector(
//                 onTap: () async {
//                   await _getImage();
//                 },
//                 child: _image != null
//                     ? Image.file(_image!, width: 200, height: 200, fit: BoxFit.cover)
//                     : //Image.asset('lib/photos/camerapic.png', width: 200, height: 200),
//                 Icon(Icons.camera_alt_outlined,size: 150,)
//             ),
//             SizedBox(height: 40,),
//             TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: 'Select the Medicines',
//                 border: OutlineInputBorder(),
//                 suffixIcon: PopupMenuButton<String>(
//                   icon: Icon(Icons.arrow_drop_down),
//                   itemBuilder: (BuildContext context) {
//                     return medicines.map((String medicine) {
//                       return PopupMenuItem<String>(
//                         value: medicine,
//                         child: Text(medicine),
//                       );
//                     }).toList();
//                   },
//                   onSelected: (String selectedMedicines) {
//                     controller.text = selectedMedicines;
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height:40 ,),
//             ElevatedButton(
//               onPressed: () async {
//                 // Save image to Firebase or perform any other required actions
//                 await _saveImageToFirebase();
//                 // Navigate to the medical alerts page
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => MyHomePage()),
//                 // );
//               },
//               child: Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _saveImageToFirebase() async {
//     if (_image == null) {
//       // Handle the case where no image is selected
//       return;
//     }
//
//     try {
//       String imageUrl = await _uploadImageToFirebase();
//       await _saveDataToFirestore(imageUrl);
//     } catch (error) {
//       // Handle the error
//       print("Error saving data to Firebase: $error");
//     }
//   }
//
//   Future<String> _uploadImageToFirebase() async {
//     // ... (Image upload logic, similar to the previous code)
//     return imageUrl;
//
//   }
//
//
//
//
//   Future<void> _saveDataToFirestore(String imageUrl) async {
//     await FirebaseFirestore.instance.collection('cruddetails').add({
//
//       'imageUrl': imageUrl,
//     });
//
//     // Navigate to the medical alerts page or perform other actions as needed
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => MyHomePage()),
//     );
//   }
//
//
//
// }
