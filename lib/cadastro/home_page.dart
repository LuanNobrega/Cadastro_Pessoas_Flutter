import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'record_provider.dart';
import 'package:provider/provider.dart';

/*
Fornece uma interface simples com dois botões que permitem navegar 
para outras partes do aplicativo: um para inserir registros e outro 
para visualizar registros salvos. A navegação é realizada utilizando 
o Navigator do Flutter.
*/

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
        leading: null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
