// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'model.dart';
// import 'bottom_nav_bar.dart';
// // import '../models/photos.dart';
//
// class HorizontalCardList extends StatefulWidget {
//   const HorizontalCardList({super.key});
//   @override
//   _HorizontalCardListState createState() => _HorizontalCardListState();
// }
//
// class _HorizontalCardListState extends State<HorizontalCardList> {
//
//   // List to store fetched photos data
//   List<Medicine> medicineList = [];
//
//   // Function to fetch data from the API
//   Future<List<Medicine>> getData() async {
//     final response = await http.get(Uri.parse('https://crudcrud.com/api/5ce5ea58371240d8a6bbe467177a25f7/medicine-list'));
//     var data = jsonDecode(response.body.toString());
//     if(response.statusCode == 200){
//       // Parse API response and populate photosList
//       for(Map i in data){
//         Medicine medicine = Medicine(name: i['name'], type: i['type'], description: i['description'], dosage: i['dosage'], price: i['price'], id: i['id']);
//
//         medicineList.add(medicine);
//       }
//       return medicineList;
//     }
//     else {
//       return medicineList;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300.0,
//       child: FutureBuilder(
//           future: getData(),
//           builder: (context,snapshot) {
//                 return ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: medicineList.length,
//     itemBuilder: (context, index) {
//           return Card(
//     // Customize your card UI as needed
//                    child: ListTile(
//                           title: Text(medicineList[index].name),
//                             subtitle: Text('Type: ${medicineList[index].description}\n'
//                        'Dosage: ${medicineList[index].dosage}\n'
//                             'Price: ${medicineList[index].id.toString()}'),
//                         ),
//                            );
//                             },
//                         );
//                               }
//                               ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'medicine.dart';


class HorizontalCardList extends StatefulWidget {
  const HorizontalCardList({Key? key}) : super(key: key);

  @override
  _HorizontalCardListState createState() => _HorizontalCardListState();
}

class _HorizontalCardListState extends State<HorizontalCardList> {
  late Future<List<Medicine>> _medicineList;

  @override
  void initState() {
    super.initState();
    _medicineList = getData();
  }

  Future<List<Medicine>> getData() async {
    final response = await http.get(Uri.parse('https://crudcrud.com/api/5ce5ea58371240d8a6bbe467177a25f7/medicine-list'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      List<Medicine> medicineList = [];
      for (Map i in data) {
        Medicine medicine = Medicine(
          name: i['name'] ?? '',
          type: i['type'] ?? '',
          description: i['description'] ?? '',
          dosage: i['dosage'] ?? '',
          price: i['price'] ?? '',
          id: i['id'] ?? ' ', tags: [],
        );
        medicineList.add(medicine);
      }
      return medicineList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: FutureBuilder(
        future: _medicineList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or any loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Medicine> medicineList = snapshot.data as List<Medicine>;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: medicineList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(medicineList[index].name),
                    subtitle: Text(
                      'Type: ${medicineList[index].description}\n'

                          'Dosage: ${medicineList[index].dosage}',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
