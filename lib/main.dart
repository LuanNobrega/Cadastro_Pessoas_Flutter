import 'package:flutter/material.dart';
import 'cadastro/read_page.dart';
import 'cadastro/insert_page.dart';
import 'cadastro/home_page.dart';
import 'package:provider/provider.dart';
import 'cadastro/record_provider.dart';

//Define a estrutura básica do aplicativo Flutter
//Definindo as rotas para as diferentes páginas da aplicação.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecordProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomePage(),
          '/read': (context) => ReadPage(),
          '/insert': (context) => InsertPage(),
        },
      ),
    ),
  );
}
