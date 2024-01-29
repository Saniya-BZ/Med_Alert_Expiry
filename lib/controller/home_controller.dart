import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../view/medicine.dart';

class HomeController extends GetxController {
  RxList<Medicine> medicines = <Medicine>[].obs;
  RxList<String> distinctTags = <String>[].obs;
  RxList<String> selectedTags = <String>[].obs;
  List<Medicine> allMedicines = [];

  final searchTextFieldController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMedicinesFromAsset();
  }

  void loadMedicinesFromAsset() async {
    try {
      String data = await rootBundle.loadString('assets/medicine_list.json');
      List<dynamic> medicineList = json.decode(data);

      List<Medicine> medicines = medicineList.map((jsonMedicine) {
        List<String> tags =
        (jsonMedicine['type'] as String).toLowerCase().split(' ');

        return Medicine(
          id: jsonMedicine['id'],
          name: jsonMedicine['name'],
          type: jsonMedicine['type'],
          description: jsonMedicine['description'],
          dosage: jsonMedicine['dosage'],
          price: jsonMedicine['price'],
          tags: tags,
        );
      }).toList();

      allMedicines = medicines;
      this.medicines.assignAll(medicines);

      // Extract distinct tags from medicines
      Set<String> allTags = medicines.fold<Set<String>>(
        Set<String>(),
            (tags, medicine) => tags..addAll(medicine.tags),
      );

      distinctTags.assignAll(allTags.toList());
    } catch (e) {
      print('Error loading medicines: $e');
    }
  }

  void filterMedicines() {
    if (selectedTags.isEmpty) {
      // If no tags selected, show all medicines
      medicines.assignAll(allMedicines);
    } else {
      // Filter medicines based on selected tags
      List<Medicine> filteredMedicines = allMedicines
          .where((medicine) =>
          medicine.tags.any((tag) => selectedTags.contains(tag)))
          .toList();
      medicines.clear();
      filteredMedicines.reversed.toList();
      medicines.assignAll(filteredMedicines);
    }
  }

  void resetFilters() {
    // Reset selected tags and show all medicines
    selectedTags.clear();
    medicines.assignAll(allMedicines);
  }


  void filterByName(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all medicines
      if(distinctTags.isNotEmpty){
        filterMedicines();
      }
      else {
        medicines.assignAll(allMedicines);
      }
    } else {
      // Filter medicines by name containing the query

      if(distinctTags.isNotEmpty){
        List<Medicine> results = medicines
            .where((medicine) =>
            medicine.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        medicines.assignAll(results);
      }
      else {
        List<Medicine> results = allMedicines
            .where((medicine) =>
            medicine.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        medicines.assignAll(results);
      }
    }
  }
}