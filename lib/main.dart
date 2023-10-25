import 'dart:convert';

import 'package:buscacnpj/http.services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Busca CNPJ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Busca CNPJ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cnpjController =
      TextEditingController(text: '64871825000164');

  final TextEditingController abertura = TextEditingController();
  final TextEditingController situacao = TextEditingController();
  final TextEditingController tipo = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController porte = TextEditingController();
  final TextEditingController telefone = TextEditingController();
  final TextEditingController ultimaatualizacao = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController fantasia = TextEditingController();

  final String _uri = 'receitaws.com.br';

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  _retornoCNPJ(int cnpj) async {
    HttpServices httpRun = HttpServices(
      baseUrl: _uri,
      endpoint: '/v1/cnpj/$cnpj',
    );
    logger.i(await HttpServices.getUri(_uri, '/v1/cnpj/$cnpj', null));

    http.Response httpResponse = await httpRun.getRequest();
    if (httpResponse.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(httpResponse.body);
      logger.i(jsonResponse);

      setState(() {
        abertura.text = jsonResponse['abertura'];
        situacao.text = jsonResponse['situacao'];
        tipo.text = jsonResponse['tipo'];
        nome.text = jsonResponse['nome'];
        porte.text = jsonResponse['porte'];
        telefone.text = jsonResponse['telefone'];
        ultimaatualizacao.text = jsonResponse['ultima_atualizacao'];
        status.text = jsonResponse['status'];
        fantasia.text = jsonResponse['fantasia'];
      });
    }
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: _cnpjController,
                keyboardType: TextInputType.number,
                maxLength: 14,
                decoration: const InputDecoration(
                  labelText: 'Digite o CNPJ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O CNPJ não pode estar vazio!';
                  }
                  if (!isNumeric(value)) {
                    return 'O CNPJ deve conter apenas números, sem traço e sem espaço!';
                  }
                  if (value.length != 14) {
                    return 'O CNPJ deve conter 14 números, sem traço e sem espaço!';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, top: 0, left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _retornoCNPJ(int.parse(_cnpjController.text.trim()));
                      },
                      child: const Text(
                        'Buscar',
                        style: TextStyle(
                          fontSize: 30,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: nome,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Razão Social',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: fantasia,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nome Fantasia',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: status,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Status',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: situacao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Situação',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: abertura,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Data de abertura',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: tipo,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: porte,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Porte',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: telefone,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
              child: TextFormField(
                controller: ultimaatualizacao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Data da ultima atualização',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
