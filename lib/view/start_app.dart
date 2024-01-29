
import 'package:flutter/material.dart';
import 'constants_ui.dart';
import 'home_view.dart';
import 'my_screen.dart';
import 'notifications.dart';
import 'settings.dart';
import 'medicines_screen.dart';


class StartApp extends StatefulWidget {
  const StartApp({super.key});
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MyScreen(),
    NotificationsScreen(),
     SettingsScreen(),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expiry Alert System'),
        ),
        drawer: const MyDrawer(),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: ColorConstants.primaryColor),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications,color: ColorConstants.primaryColor),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: ColorConstants.primaryColor),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_information,color: ColorConstants.primaryColor),
                label: 'Medicines'
            ),
          ],
          selectedItemColor: ColorConstants.primaryColor,
          unselectedItemColor: Colors.grey,


        ),
      ),
    );
  }
}



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text('Expiry Alert System'),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pop(context);

            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SettingsScreen()),
              );

            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active_sharp),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  NotificationsScreen()),
              );

            },
          ),


          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('About us'),
          //   onTap: () {
          //     Navigator.pop(context);
          //
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.medical_information),
            title: const Text('Medicines'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  HomeView()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout,color: ColorConstants.primaryColor,),
            title: const Text('Logout',style: TextStyle(color: ColorConstants.primaryColor),),
            onTap: () {
              Navigator.pop(context);

            },
          ),
        ],
      ),
    );
  }
}