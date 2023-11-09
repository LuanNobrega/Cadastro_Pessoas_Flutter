import 'package:flutter/material.dart';
import 'record_provider.dart';
import 'package:provider/provider.dart';

class ReadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final records = Provider.of<RecordProvider>(context).records;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registros'),
        leading: null,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  title: Text('Nome: ${record.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Idade: ${record.age}'),
                      Text('Sexo: ${record.gender}'),
                      Text('Email: ${record.email}'),
                      Text('Profissão: ${record.profession}'),
                      Text('Naturalidade: ${record.city}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editRecord(context, record);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteRecord(context, index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16), // Espaçamento entre os botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/insert');
                },
                child: Text('Inserir Registro'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text('Voltar para página inicial'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editRecord(BuildContext context, Record record) {
    // Navegue para a página de edição e passe o registro a ser editado.
    Navigator.pushNamed(context, '/insert', arguments: record);
  }

  void _deleteRecord(BuildContext context, int index) {
    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    recordProvider.deleteRecord(index);

    // Opcional: Exibir um SnackBar ou uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registro excluído com sucesso!')),
    );
  }
}
