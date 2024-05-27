import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


class CadastroProd {
  final String codigo;
  final String nome;
  final double preco;
  final int quantidade;


  CadastroProd({required this.codigo, required this.nome, required this.preco, required this.quantidade});
}


class MyConsulta extends StatefulWidget {
  const MyConsulta({Key? key}) : super(key: key);


  @override
  State<MyConsulta> createState() => _MyConsultaState();
}


class _MyConsultaState extends State<MyConsulta> {
  MySqlConnection? _connection;
  List<CadastroProd> resultadoConsulta = [];
  TextEditingController _controller = TextEditingController();
  bool _buscarPorCodigo = true;


  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }


  Future<void> _connectToDatabase() async {
    _connection = await MySqlConnection.connect(ConnectionSettings(
      host: '143.106.241.3',
      port: 3306,
      user: 'cl202203',
      password: 'cl*25042007',
      db: 'cl202203',
    ));
  }


  Future<void> _consultarLista(String termo) async {
    if (_connection == null) {
      return; // Abortar se a conexão não estiver inicializada
    }


    final results = _buscarPorCodigo
        ? await _connection!.query('SELECT * FROM SyProduto WHERE codigo LIKE ?', ['%$termo%'])
        : await _connection!.query('SELECT * FROM SyProduto WHERE nome LIKE ?', ['%$termo%']);


    setState(() {
      resultadoConsulta = results.map((row) => CadastroProd(
        codigo: row['codigo'].toString(),
        nome: row['nome'],
        preco: row['preco'].toDouble(),
        quantidade: row['quantidade'],
      )).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text(
          'Consultar',
          style: TextStyle(color: Colors.white),
        ),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: _buscarPorCodigo ? 'Buscar por código' : 'Buscar por nome',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      _buscarPorCodigo = !_buscarPorCodigo;
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _consultarLista(_controller.text);
              },
              child: Text('Consultar'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Código')),
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Preço')),
                    DataColumn(label: Text('Quantidade')),
                  ],
                  rows: resultadoConsulta.map((produto) {
                    return DataRow(cells: [
                      DataCell(Text(produto.codigo)),
                      DataCell(Text(produto.nome)),
                      DataCell(Text(produto.preco.toStringAsFixed(2))),
                      DataCell(Text(produto.quantidade.toString())),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _connection?.close();
    super.dispose();
  }
}





