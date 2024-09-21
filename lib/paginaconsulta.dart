import 'package:flutter/material.dart';

class FuncionarioFormWidget extends StatefulWidget {
  @override
  _FuncionarioFormWidgetState createState() => _FuncionarioFormWidgetState();
}

class _FuncionarioFormWidgetState extends State<FuncionarioFormWidget> {
  TextEditingController controlaTexto = TextEditingController();
  bool _showFuncionarioTable = false;
  bool _showProdutoTable = false;
  bool _atuProduto = false;
  bool _atuFuncionario = false;
  bool _muda = false;
  bool _showButton = true;
  bool _showButton1 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: controlaTexto,
                    decoration: InputDecoration(
                      labelText: 'Buscar por nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    ),
                    style: TextStyle(fontFamily: "Space_Grotesk"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            SizedBox(height: 20),

            if (_showFuncionarioTable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 600,
                  child: DataTable(
                    columnSpacing: 20.0,
                    dataRowHeight: 50.0,
                    columns: [
                      DataColumn(label: Text('Nome', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataColumn(label: Text('CPF', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataColumn(label: Text('Email', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Daniela Mendonça', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('12345678910', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('cl202203@g.unicamp.br', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Heloise Kuhl de Oliveira', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('01987654321', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('cl202234@g.unicamp.br', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Gonçalo Henrique da Cruz', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('11223344556', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('cl202233@g.unicamp.br', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Maria Eduarda Silva Demonte', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('66778899001', style: TextStyle(fontFamily: "Space_Grotesk"))),
                        DataCell(Text('cl202251@g.unicamp.br', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      ]),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 15,),

            Visibility(
              visible: _showButton,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showButton = false;
                    _showButton1 = true;
                    _showFuncionarioTable = true;
                    _showProdutoTable = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.cyan[300],
                ),
                child: Text('Consultar Funcionário', style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk")),
              ),
            ),
            SizedBox(height: 20,),

            Visibility(
              visible: _showButton1,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _atuProduto = false;
                    _atuFuncionario = true;
                    _showButton = true;
                    _showButton1 = false;

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Atualizado com Sucesso', style: TextStyle(fontFamily: "Space_Grotesk")),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK', style: TextStyle(fontFamily: "Space_Grotesk")),
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.cyan[300],
                ),
                child: Text('Atualizar Funcionário', style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProdutoFormWidget extends StatefulWidget {
  @override
  _ProdutoFormWidgetState createState() => _ProdutoFormWidgetState();
}

class _ProdutoFormWidgetState extends State<ProdutoFormWidget> {
  TextEditingController controlaTexto = TextEditingController();
  bool _buscarPorCodigo = true;
  bool _showFuncionarioTable = false;
  bool _showProdutoTable = false;
  bool _showButton2 = true;
  bool _showButton3 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: controlaTexto,
                    decoration: InputDecoration(
                      labelText: _buscarPorCodigo ? 'Buscar por código' : 'Buscar por nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.swap_horiz),
                        onPressed: () {
                          setState(() {
                            _buscarPorCodigo = !_buscarPorCodigo;
                            controlaTexto.clear();
                          });
                        },
                      ),
                    ),
                    style: TextStyle(fontFamily: "Space_Grotesk"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            SizedBox(height: 20),

            if (_showProdutoTable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  dataRowHeight: 48.0,
                  columns: [
                    DataColumn(label: Text('Código', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    DataColumn(label: Text('Nome', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    DataColumn(label: Text('Preço', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    DataColumn(label: Text('Quantidade', style: TextStyle(fontFamily: "Space_Grotesk"))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('001', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('Óleo', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('R\$ 10,00', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('50', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('002', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('Sabão Em Pó', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('R\$ 20,00', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('30', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('003', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('Shampoo', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('R\$ 25,00', style: TextStyle(fontFamily: "Space_Grotesk"))),
                      DataCell(Text('40', style: TextStyle(fontFamily: "Space_Grotesk"))),
                    ]),
                  ],
                ),
              ),

            SizedBox(height: 15,),
            Visibility(
              visible: _showButton2,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showButton2 = false;
                    _showButton3 = true;
                    _showProdutoTable = true;
                    _showFuncionarioTable = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.cyan[300],
                ),
                child: Text('Consultar Produto', style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk")),
              ),
            ),

            Visibility(
              visible: _showButton3,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showButton2 = true;
                    _showButton3 = false;
                    _showProdutoTable = true;
                    _showFuncionarioTable = false;

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Atualizado com Sucesso', style: TextStyle(fontFamily: "Space_Grotesk")),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK', style: TextStyle(fontFamily: "Space_Grotesk")),
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.cyan[300],
                ),
                child: Text('Atualizar Produto', style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
