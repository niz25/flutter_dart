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
      
            SizedBox(height: 20),

        if (_showFuncionarioTable)
  SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      width: 600, // Defina a largura necessária para forçar a rolagem horizontal
      child: DataTable(
        columnSpacing: 20.0,
        dataRowHeight: 50.0,
        columns: [
          DataColumn(label: Text('Nome')),
          DataColumn(label: Text('CPF')),
          DataColumn(label: Text('Email')),
        ],
        rows: [
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
  ),

              SizedBox(height: 15,),

            Visibility(
       visible: _showButton,
        child:
            ElevatedButton
            (
              onPressed: () {
                  
                setState(() {
                  _showButton = false;
                   _showButton1 = true;
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
              child: Text('Consultar Funcionário', style: TextStyle(color: Colors.white)),
            ),),
            SizedBox(height: 20,),

              Visibility(
       visible: _showButton1,
        child:
           ElevatedButton
            (
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
                        title: Text('Atualizado com Sucesso'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                    );
               
                });
                    
              },
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                minimumSize: Size(200, 50),
                backgroundColor: Colors.cyan[300],
              ),
              child: Text('Atualizar Funcionário', style: TextStyle(color: Colors.white)),
            ),),
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
  bool  _showButton2 = true;
  bool  _showButton3 = false;

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
              SizedBox(height: 15,),
               Visibility(
       visible: _showButton2,
        child:  ElevatedButton
            (
              onPressed: () {
                setState(() {
                   _showButton2 = false;
                   _showButton3 = true;
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
              child: Text('Consultar Produto', style: TextStyle(color: Colors.white),),
            ),),

                Visibility(
       visible: _showButton3,
        child:  ElevatedButton
            (
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
                        title: Text('Atualizado com Sucesso'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                    );

                  
                });
              },
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                minimumSize: Size(200, 50),
                backgroundColor: Colors.cyan[300],
              ),
              child: Text('Atualizar Produto', style: TextStyle(color: Colors.white),),
            ),),
          ],
        ),
      ),
    );
  }
}
