import 'package:flutter/material.dart';

class FuncionarioFormWidget extends StatefulWidget {
  @override
  _FuncionarioFormWidgetState createState() => _FuncionarioFormWidgetState();
}

class _FuncionarioFormWidgetState extends State<FuncionarioFormWidget> {
  TextEditingController controlaTexto = TextEditingController();
  bool _showFuncionarioTable = false;
  bool _showProdutoTable = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView
    (
      child: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: Column
        (
          children: 
          [
            Row
            (
              children: 
              [
                Flexible
                (
                  child: TextField
                  (
                    controller: controlaTexto,
                    decoration: InputDecoration
                    (
                      labelText: 'Buscar por nome',
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton
            (
              onPressed: () {
                setState(() {
                  _showFuncionarioTable = true;
                  _showProdutoTable = false;
                });
              },
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                minimumSize: Size(200, 50),
                backgroundColor: Colors.cyan[300],
              ),
              child: Text('Consultar Funcionário'),
            ),

            SizedBox(height: 20),

            if (_showFuncionarioTable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable
                (
                  columnSpacing: 36.0,
                  dataRowHeight: 48.0,
                  columns: 
                  [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('CPF')),
                    DataColumn(label: Text('Email')),
                  ],
                  rows: 
                  [
                    DataRow(cells: [
                      DataCell(Text('Daniela Mendonça')),
                      DataCell(Text('12345678910')),
                      DataCell(Text('cl202203@g.unicamp.br')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Heloise Kuhl de Oliveira')),
                      DataCell(Text('01987654321')),
                      DataCell(Text('cl202234@g.unicamp.br')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Gonçalo Henrique da Cruz')),
                      DataCell(Text('11223344556')),
                      DataCell(Text('cl202233@g.unicamp.br')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Maria Eduarda Silva Demonte')),
                      DataCell(Text('66778899001')),
                      DataCell(Text('cl202251@g.unicamp.br')),
                    ]),
                  ],
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView
    (
      child: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: Column
        (
          children: 
          [
            Row
            (
              children: 
              [
                Flexible
                (
                  child: TextField
                  (
                    controller: controlaTexto,
                    decoration: InputDecoration
                    (
                      labelText: _buscarPorCodigo ? 'Buscar por código' : 'Buscar por nome',
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      suffixIcon: IconButton
                      (
                        icon: Icon(Icons.swap_horiz),
                        onPressed: () {
                          setState(() {
                            _buscarPorCodigo = !_buscarPorCodigo;
                            controlaTexto.clear();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton
            (
              onPressed: () {
                setState(() {
                  _showProdutoTable = true;
                  _showFuncionarioTable = false;
                });
              },
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                minimumSize: Size(200, 50),
                backgroundColor: Colors.cyan[300],
              ),
              child: Text('Consultar Produto'),
            ),

            SizedBox(height: 20),

            if (_showProdutoTable)
              SingleChildScrollView
              (
                scrollDirection: Axis.horizontal,
                child: DataTable
                (
                  columnSpacing: 16.0,
                  dataRowHeight: 48.0,
                  columns: [
                    DataColumn(label: Text('Código')),
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Preço')),
                    DataColumn(label: Text('Quantidade')),
                  ],
                  rows:
                  [
                    DataRow(cells: [
                      DataCell(Text('001')),
                      DataCell(Text('Óleo')),
                      DataCell(Text('R\$ 10,00')),
                      DataCell(Text('50')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('002')),
                      DataCell(Text('Sabão Em Pó')),
                      DataCell(Text('R\$ 20,00')),
                      DataCell(Text('30')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('003')),
                      DataCell(Text('Shampoo')),
                      DataCell(Text('R\$ 25,00')),
                      DataCell(Text('40')),
                    ]),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
