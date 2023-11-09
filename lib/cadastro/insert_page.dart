import 'package:flutter/material.dart';
import 'record_provider.dart';
import 'package:provider/provider.dart';

class InsertPage extends StatefulWidget {
  final Record?
      recordToEdit; // Novo parâmetro para receber o registro a ser editado
  InsertPage({this.recordToEdit});

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

  @override
  void initState() {
    super.initState();
    // Preencha os campos com os dados do registro a ser editado, se estiver presente.
    if (widget.recordToEdit != null) {
      final record = widget.recordToEdit!;
      nameController.text = record.name;
      ageController.text = record.age.toString();
      selectedGender = record.gender;
      emailController.text = record.email;
      professionController.text = record.profession;
      cityController.text = record.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _insertRecord(context);
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                clearFields();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Campos limpos com sucesso!')),
                );
              },
              child: Text('Limpar Campos'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/read');
              },
              child: Text('Visualizar registros salvos'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Voltar para página inicial'),
            ),
          ],
        ),
      ),
    );
  }

  // Limpar os campos após a inserção.
  void clearFields() {
    nameController.clear();
    ageController.clear();
    selectedGender = null;
    emailController.clear();
    professionController.clear();
    cityController.clear();
  }

  void _insertRecord(BuildContext context) {
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
        name: name,
        age: int.parse(age),
        gender: selectedGender!,
        email: email,
        profession: profession,
        city: city,
      ));

      clearFields();

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
