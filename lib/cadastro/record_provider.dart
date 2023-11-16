import 'package:flutter/material.dart';

class Record {
  final String? id;
  final String name;
  final int age;
  final String gender;
  final String email;
  final String profession;
  final String city;

  Record({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.email,
    required this.profession,
    required this.city,
  });
}

class RecordProvider with ChangeNotifier {
  List<Record> records = [];

  void addRecord(Record record) {
    records.add(record);
    notifyListeners();
  }

  void updateRecord(Record record) {
    records.removeWhere((e) => e.id == record.id);
    records.add(record);
    notifyListeners();
  }

  void deleteRecord(Record record) {
    records.removeWhere((e) => e.id == record.id);
    notifyListeners();
  }
}
