// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// // Initialize FlutterLocalNotificationsPlugin
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "IZbs7fcDDyOUgbYf3wMS",
//       appId: "1:611033120586:android:7693c5d6981c18ed650bb3",
//       projectId: "expiry-system",
//       messagingSenderId: '',
//     ),
//   );
//
//   // Initialize FlutterLocalNotificationsPlugin
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   // Create a notification channel for Android
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'expiry_system_channel',
//     'Expiry System Channel',
//    // 'Channel for expired data notifications',
//     importance: Importance.high,
//   );
//
//   // Initialize the notification plugin with the channel
//   await flutterLocalNotificationsPlugin.initialize(
//     InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//     ),
//     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//   );
//
//   runApp(const MyApp());
// }
//
// Future<void> onDidReceiveNotificationResponse(NotificationResponse response) async {
//   print('Notification received: $response');
// }
// Future<void> requestNotificationPermission() async {
//   final PermissionStatus status = await Permission.notification.request();
//   if (status == PermissionStatus.granted) {
//     print('Notification permission granted.');
//   } else {
//     print('Notification permission not granted.');
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _create();
//         },
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       appBar: AppBar(
//         title: const Text('Hello'),
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
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Text(
//                         DateFormat.yMd().format(documentSnapshot['date'].toDate())),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               _update(documentSnapshot);
//                             },
//                             icon: const Icon(Icons.edit),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               _delete(documentSnapshot.id);
//                             },
//                             icon: const Icon(Icons.delete),
//                           )
//                         ],
//                       ),
//                     ),
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
//
//
//
//                     print('Selected Date: $_selectedDate');
//                     if (_selectedDate.year == 2024 && _selectedDate.month == 2 && _selectedDate.day == 2) {
//                       print('Condition met! Showing custom notification.');
//                       await showCustomNotification(); // Show a custom notification
//                     } else {
//                       print('Condition not met.');
//                     }
//
//                     // Check if the selected date is "2nd Feb 2023"
//                     // if (_selectedDate.year == 2023 &&
//                     //     _selectedDate.month == 2 &&
//                     //     _selectedDate.day == 2) {
//                     //   await showCustomNotification(); // Show a custom notification
//                     // }
//                   }
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
//   Future<void> showCustomNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'expiry_system_channel',
//       'Expiry System Channel name',
//       //'Channel for custom notifications',
//       importance: Importance.high,
//     );
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'Hello World',
//       'This is a custom notification!',
//       platformChannelSpecifics,
//       payload: 'custom_notification',
//     );
//   }
//
//
//
//
//
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
//   // Future<void> showExpiredNotification() async {
//   //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   //   AndroidNotificationDetails(
//   //     'expiry_system_channel',
//   //     'Expiry System Channel',
//   //    // 'Channel for expired data notifications',
//   //     importance: Importance.high,
//   //   );
//   //
//   //   const NotificationDetails platformChannelSpecifics =
//   //   NotificationDetails(android: androidPlatformChannelSpecifics);
//   //
//   //   await flutterLocalNotificationsPlugin.show(
//   //     0, // Notification ID
//   //     'Data Expired',
//   //     'The selected data has expired!',
//   //     platformChannelSpecifics,
//   //     payload: 'data_expired',
//   //   );
//   // }
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "IZbs7fcDDyOUgbYf3wMS",
//       appId: "1:611033120586:android:7693c5d6981c18ed650bb3",
//       projectId: "expiry-system",
//       messagingSenderId: '',
//     ),
//   );
//
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'expiry_system_channel',
//     'Expiry System Channel',
//     // 'Channel for expired data notifications',
//     importance: Importance.high,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(
//     InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//     ),
//     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//   );
//
//   runApp(const MyApp());
// }
//
// Future<void> onDidReceiveNotificationResponse(NotificationResponse response) async {
//   print('Notification received: $response');
// }
// Future<void> requestNotificationPermission() async {
//   final PermissionStatus status = await Permission.notification.request();
//   if (status == PermissionStatus.granted) {
//     print('Notification permission granted.');
//   } else {
//     print('Notification permission not granted.');
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final CollectionReference _cruddetails = FirebaseFirestore.instance.collection('cruddetails');
//   final TextEditingController _nameController = TextEditingController();
//   DateTime _selectedDate = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hello'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _scheduleNotification();
//           },
//           child: const Text('Choose Date and Schedule Notification'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _scheduleNotification() async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (selectedDate != null) {
//       setState(() {
//         _selectedDate = selectedDate;
//       });
//
//       // Check if selected date is "2nd Feb 2024"
//       if (_selectedDate.year == 2024 && _selectedDate.month == 2 && _selectedDate.day == 2) {
//         // Schedule notification after 5 seconds
//         Future.delayed(const Duration(seconds: 5), () {
//           _showDelayedNotification();
//         });
//       }
//     }
//   }
//
//   Future<void> _showDelayedNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'expiry_system_channel',
//       'Expiry System Channel',
//      // 'Channel for expired data notifications',
//       importance: Importance.high,
//     );
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'Hello World',
//       'This is a delayed notification!',
//       platformChannelSpecifics,
//       payload: 'delayed_notification',
//     );
//   }
// }
//hello final

import 'package:crud_new/view/onboarding_screen.dart';
import 'package:crud_new/view/start_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'view/constants_ui.dart';
import 'view/notification_provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "IZbs7fcDDyOUgbYf3wMS",
      appId: "1:611033120586:android:7693c5d6981c18ed650bb3",
      projectId: "expiry-system",
      messagingSenderId: '',
    ),
  );

  // Initialize Awesome Notifications
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      ),
    ],
  );

  // Ensure notification permission
  bool isAllowedToSendNotification =
  await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
     child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Open Sans',
          colorScheme:
          ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
          primaryColor: ColorConstants.primaryColor,
          useMaterial3: true,
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}



