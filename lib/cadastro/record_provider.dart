import 'package:flutter/material.dart';

/*
A classe RecordProvider no arquivo record_provider.dart é
uma classe que estende ChangeNotifier e é usada para
gerenciar o estado dos registros em um aplicativo Flutter.
*/

class Record {
  final String name;
  final int age;
  final String gender;
  final String email;
  final String profession;
  final String city;

  Record({
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

  void deleteRecord(int index) {
    if (index >= 0 && index < records.length) {
      records.removeAt(index);
      notifyListeners();
    }
  }

  void editRecord(int index, Record newRecord) {
    if (index >= 0 && index < records.length) {
      records[index] = newRecord;
      notifyListeners();
    }
  }
}
