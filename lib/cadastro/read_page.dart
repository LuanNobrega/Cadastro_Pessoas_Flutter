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
                  trailing: SizedBox(
                    width: 300,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/insert',
                                arguments: {'id': record.id});
                          },
                          child: Text("Editar"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final recordProvider = Provider.of<RecordProvider>(
                                context,
                                listen: false);
                            recordProvider.deleteRecord(record);
                          },
                          child: Text("Deletar"),
                        ),
                      ],
                    ),
                  ),
                  title: Text('Nome: ${record.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Id: ${record.id}'),
                      Text('Idade: ${record.age}'),
                      Text('Sexo: ${record.gender}'),
                      Text('Email: ${record.email}'),
                      Text('Profissão: ${record.profession}'),
                      Text('Naturalidade: ${record.city}'),
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
}
