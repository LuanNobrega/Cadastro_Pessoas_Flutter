import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'record_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final records = Provider.of<RecordProvider>(context).records;
    // if (records.isEmpty) {
    //   Record record = Record(
    //       id: '12121212221212',
    //       name: 'Tiago',
    //       age: 10,
    //       gender: 'Masculino',
    //       email: 'sfkshkja@gmail.com',
    //       profession: 'Tecnico em Eletronica',
    //       city: 'Joao Pessoa');
    //   records.add(record);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
        leading: null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Text(
              'Aplicação para cadastro de pessoas',
              style: TextStyle(fontSize: 20),
            ),*/
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/insert');
              },
              child: Text('Inserir Registro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/read');
              },
              child: Text('Visualizar registros salvos'),
            ),
          ],
        ),
      ),
    );
  }
}
