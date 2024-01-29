//Actual 1
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'notification_provider.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications =
        Provider.of<NotificationProvider>(context).notifications;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Medicine Notifications'),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_hex_green.png'),
            fit: BoxFit.cover
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cruddetails').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No Medicine Notifications'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                final notificationText = '${documentSnapshot['name']} will expire on ${DateFormat.yMd().format(documentSnapshot['date'].toDate())}';
                final notificationTime = DateFormat.Hm().format(DateTime.now());

                // Notify NotificationProvider with the new notification
                Provider.of<NotificationProvider>(context, listen: false).addNotification({
                  'text': notificationText,
                  'time': notificationTime,
                });

                return Card(
                  color: Colors.white,
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      documentSnapshot['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Expiry Date: ${DateFormat.yMd().format(documentSnapshot['date'].toDate())}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.notifications_active,color: Colors.red,),
                      backgroundColor: Colors.white,
                    ),
                    trailing: Text(
                      'Time: $notificationTime',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

