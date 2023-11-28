import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'record_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class InsertPage extends StatefulWidget {
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? selectedGender;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final records = Provider.of<RecordProvider>(context).records;
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      id = arguments['id'];
      if (records.isNotEmpty) {
        var record = records.firstWhere((e) => e.id == id);
        if (!record.isNull) {
          nameController.text = record.name;
          ageController.text = record.age.toString();
          emailController.text = record.email;
          professionController.text = record.profession;
          cityController.text = record.city;
          selectedGender = record.gender;
        }
        print("Record: ${record.id}");
      }
    } catch (e) {
      print(e.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Para expandir os botões na largura máxima
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Idade'),
              keyboardType: TextInputType.number,
            ),
            // Opções de seleção de gênero usando botões de rádio
            ListTile(
              title: Text('Sexo'),
              contentPadding: EdgeInsets.all(0),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Radio(
                    value: 'Masculino',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  Text('Masculino'),
                  Radio(
                    value: 'Feminino',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  Text('Feminino'),
                ],
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: professionController,
              decoration: InputDecoration(labelText: 'Profissão'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Naturalidade'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8), // Espaçamento vertical entre os botões
              child: ElevatedButton(
                onPressed: () {
                  if (id.isNull) {
                    _insertRecord(context);
                  } else {
                    _updateRecord(context, id);
                  }
                },
                child: Text('Salvar'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8), // Espaçamento vertical entre os botões
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/read');
                },
                child: Text('Visualizar registros salvos'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8), // Espaçamento vertical entre os botões
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text('Voltar para página inicial'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertRecord(BuildContext context) {
    final id = Uuid().v1();
    final name = nameController.text;
    final age = ageController.text;
    final email = emailController.text;
    final profession = professionController.text;
    final city = cityController.text;

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        int.tryParse(age) != null && // Verifica se é um número inteiro
        selectedGender != null &&
        email.isNotEmpty &&
        profession.isNotEmpty &&
        city.isNotEmpty) {
      final recordProvider =
          Provider.of<RecordProvider>(context, listen: false);
      recordProvider.addRecord(Record(
        id: id,
        name: name,
        age: int.parse(age),
        gender: selectedGender!,
        email: email,
        profession: profession,
        city: city,
      ));

      // Limpar os campos após a inserção.
      nameController.clear();
      ageController.clear();
      selectedGender = null;
      emailController.clear();
      professionController.clear();
      cityController.clear();

      // Opcional: Exibir um SnackBar ou uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro inserido com sucesso!')));
      Navigator.pushNamed(context, '/read');
    } else {
      // Opcional: Exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Preencha todos os campos obrigatórios e certifique-se de que a idade seja um número inteiro.')));
    }
  }

  void _updateRecord(BuildContext context, String? id) {
    final name = nameController.text;
    final age = ageController.text;
    final email = emailController.text;
    final profession = professionController.text;
    final city = cityController.text;

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        int.tryParse(age) != null && // Verifica se é um número inteiro
        selectedGender != null &&
        email.isNotEmpty &&
        profession.isNotEmpty &&
        city.isNotEmpty) {
      final recordProvider =
          Provider.of<RecordProvider>(context, listen: false);

      recordProvider.updateRecord(Record(
        id: id,
        name: name,
        age: int.parse(age),
        gender: selectedGender!,
        email: email,
        profession: profession,
        city: city,
      ));

      // Limpar os campos após a inserção.
      nameController.clear();
      ageController.clear();
      selectedGender = null;
      emailController.clear();
      professionController.clear();
      cityController.clear();

      // Opcional: Exibir um SnackBar ou uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro inserido com sucesso!')));
      Navigator.pushNamed(context, '/read');
    } else {
      // Opcional: Exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Preencha todos os campos obrigatórios e certifique-se de que a idade seja um número inteiro.')));
    }
  }
}
