import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine List'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.searchTextFieldController,
                onChanged: (value) {
                  controller.filterByName(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search by Drug Name',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showFilterBottomSheet(context);
                  },
                  child: Text('Select Filters'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.resetFilters();
                  },
                  child: Text('Reset Filters'),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.medicines.length,
                  itemBuilder: (context, index) {
                    var medicine = controller.medicines[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text(medicine.name,style: TextStyle(color: Colors.black,fontSize: 18),),
                          Text(medicine.type,style: TextStyle(color: Colors.blueGrey,fontSize: 14),),
                          Text(medicine.description,style: TextStyle(color: Colors.grey,fontSize: 12),)
                        ],
                        // Add more details or customize the ListTile as needed
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.resetFilters();
        },
        tooltip: 'Load Medicines',
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              // Wrap the content in a SingleChildScrollView
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // Set crossAxisAlignment to stretch
                  children: [
                    Text(
                      'Select Filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      children: [
                        for (var tag in controller.distinctTags)
                          CheckboxListTile(
                            title: Text(tag),
                            value: controller.selectedTags.contains(tag),
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (value) {
                                    controller.selectedTags.add(tag);
                                  } else {
                                    controller.selectedTags.remove(tag);
                                  }
                                  controller.filterMedicines();
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}