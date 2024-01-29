// import 'package:crud_new/crud_page.dart';
// import 'package:flutter/material.dart';
// import 'view.dart';
//
//
//
// class BottomNavBarDemo extends StatefulWidget {
//   @override
//   _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
// }
//
// class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
//   int _selectedIndex = 0;
//
//   // Define your pages here
//   final List<Widget> _pages = [
//     HorizontalCardList(),
//     MyHomePage(),
//   ];
//
//   // Handle item tap
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info),
//             label: 'About',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:crud_new/view/view.dart';
import 'package:flutter/material.dart';
import 'crud_new.dart';

class MyNav extends StatefulWidget {
  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  int _selectedIndex = 0;

  // Add your page widgets here
  List<Widget> _widgetOptions = <Widget>[
    //ExpiryAlertScreen(),
     const MyHomePage(),
    const HorizontalCardList(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}





