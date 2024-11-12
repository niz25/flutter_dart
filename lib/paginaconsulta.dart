// ignore_for_file: unused_field, use_key_in_widget_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FuncionarioFormWidget extends StatefulWidget {
  @override
  _FuncionarioFormWidgetState createState() => _FuncionarioFormWidgetState();
}

class _FuncionarioFormWidgetState extends State<FuncionarioFormWidget> {
  TextEditingController controlaTexto = TextEditingController();
  bool _isLoading = false;
  bool _showFuncionarioTable = false;

  // lista que armazena os funcionarios
  List<dynamic> funcionarios = [];

  // busca funcionários por nome
  Future<String> buscarFuncionariosPorNome(String nome) async 
  {
    String url = 'http://localhost:8080/apiFuncionario/funcionarios/nome/$nome';

    try 
    {
      final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) 
      {
        return response.body;
      } 
      else 
      {
        return 'Erro ao buscar funcionários: ${response.statusCode}';
      }
    } 
    catch (e) 
    {
      return 'Erro na conexão: $e';
    }
  }

  Future<String> atualizarFuncionario(Map<String, dynamic> funcionarios) async
  {
    var url = Uri.parse('http://localhost:8080/apiFuncionario/atualizarFuncionarios');

    try
    {
      final response = await http.put
      (
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(funcionarios),
      );

      if(response.statusCode == 200)
      {
        return "Funcionário atualizado com SUCESSO!";
      }
      else if(response.statusCode == 404)
      {
        return "Funcionário não encontrado.";
      }
      else
      {
        return "Erro ao atualizar o funcionário: ${response.statusCode}";
      }
    }
    catch(e)
    {
      return "Erro na conexão: $e";
    }
  }

  // Função para buscar funcionários
  void buscarFuncionariosFunc() async 
  {
    setState(() {
      _isLoading = true;
    });

    String nome = controlaTexto.text.trim();

    if (nome.isEmpty) 
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, insira um nome para busca.')));

      setState(() {
        _isLoading = false;
      });

      return;
    }

    String resultado = await buscarFuncionariosPorNome(nome);

    setState(() {
      _isLoading = false;
    });

    if (resultado.startsWith('Erro')) 
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)));
    } 
    else 
    {
      var funcionariosRetornados = jsonDecode(resultado);

      if (funcionariosRetornados.isEmpty) 
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nenhum funcionário encontrado para "$nome".')));
      } 
      else 
      {
        setState(() {
          funcionarios = funcionariosRetornados;
          _showFuncionarioTable = true;
        });
      }
    }
  }

  void atualizarFuncionarioFunc(Map<String, dynamic> funcionarios) async
  {
    String resultado = await atualizarFuncionario(funcionarios);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)),);

    if(resultado.contains("sucesso"))
    {
      buscarFuncionariosFunc();
    }
  }

  void mostraDialogoAtualizar(Map<String, dynamic> funcionarios)
  {
    TextEditingController nomeController = TextEditingController(text: funcionarios['nome']);
    TextEditingController cpfController = TextEditingController(text: funcionarios['cpf']);
    TextEditingController emailController = TextEditingController(text: funcionarios['email']);

    showDialog
    (
      context: context, 
      builder: (context) 
      {
        return AlertDialog
        (
          title: Text('Atualizar Funcionário', style: TextStyle(fontFamily: "Space_Grotesk", color: Colors.cyan[300])),
          content: SingleChildScrollView
          (
            child: Column
            (
              children: 
              [
                TextField
                (
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  style: TextStyle(fontFamily: "Space_Grotesk"),
                ),

                SizedBox(height: 15,),

                TextField
                (
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  style: TextStyle(fontFamily: "Space_Grotesk"),
                ),
              ],
            ),
          ),
          actions: 
          [
            TextButton
            (
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(fontFamily: "Space_Grotesk"),),
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.cyan[300],
              ),
            ),

            ElevatedButton
            (
              onPressed: () {
                Map<String, dynamic> funcionarioAtualizado = 
                {
                  "nome": nomeController.text,
                  "cpf": funcionarios['cpf'],
                  "email": emailController.text,
                };
                atualizarFuncionario(funcionarioAtualizado);
                Navigator.of(context).pop();
              },
              child: Text('Atualizar', style: TextStyle(fontFamily: "Space_Grotesk")),
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.cyan[300],
              ),
            ),
          ],
        );
      },
    );
  }

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
                      labelText: 'Buscar por Nome', 
                      labelStyle: TextStyle(fontFamily: "Space_Grotesk"),
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
                
            if(_showFuncionarioTable)
              SingleChildScrollView
              (
                scrollDirection: Axis.horizontal,
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.cyan, width: 2),
                  ),
                  child: DataTable
                  (
                    columnSpacing: 16.0,
                    dataRowHeight: 50.0,
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan[100]!),
                    columns: 
                    [
                      DataColumn(label: Text('Nome', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('CPF', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Email', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Atualizar', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                    ],
                    rows: funcionarios.map<DataRow>((funcionarios) 
                    {
                      return DataRow
                      (
                        cells: 
                        [
                          DataCell(Text(funcionarios['nome'] ?? '', style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell(Text(funcionarios['cpf'].toString(), style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell(Text(funcionarios['email'] ?? '', style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell
                          (
                            IconButton
                            (
                              icon: Icon(Icons.edit, color: Colors.cyan),
                              onPressed: () {
                                mostraDialogoAtualizar(funcionarios);
                              },
                            )
                          ),
                        ],
                      );
                    }).toList(),

                ),
              )
            ),

            SizedBox(height: 20,),

            ElevatedButton
            (
              onPressed: _isLoading ? null : buscarFuncionariosFunc, 
              child: Row
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  if (_isLoading) 
                    Padding
                    (
                      padding: const EdgeInsets.only(right: 2.0), 
                      child: CircularProgressIndicator
                      (
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white), 
                        strokeWidth: 0.5,
                      ),
                    ),
                    
                    Text(_isLoading ? 'Carregando...' : 'Consultar Funcionário'), 
                  ],
                ), style: ElevatedButton.styleFrom
                  (
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
            )
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------------------------------------- */

class ProdutoFormWidget extends StatefulWidget {
  @override
  _ProdutoFormWidgetState createState() => _ProdutoFormWidgetState();
}

class _ProdutoFormWidgetState extends State<ProdutoFormWidget> {
  TextEditingController controlaTexto = TextEditingController();
  bool _buscarPorCodigo = true;
  bool _showProdutoTable = false;
  bool _isLoading = false;

  // lista que armazena os produtos
  List<dynamic> produtos = []; 

  // busca produtos por código ou nome
  Future<String> buscarProdutos(String tipoBusca, String valor) async 
  {
    String url = "";  

    if(tipoBusca == 'codigo') 
    {
      url = 'http://localhost:8080/apiProdutos/produtos/codigo/$valor'; 
    } 
    else if(tipoBusca == 'nome') 
    {
      url = 'http://localhost:8080/apiProdutos/produtos/nome/$valor'; 
    } 
    else 
    {
      return 'Tipo de busca inválido';  
    }

    try 
    {
      final response = await http.get(Uri.parse(url),headers: {'Content-Type': 'application/json; charset=UTF-8'},);

      if(response.statusCode == 200) 
      {
        return response.body;  
      } 
      else 
      {
        // caso não haja a requisição (se falhar)
        return 'Erro ao buscar produtos: ${response.statusCode}';  
      }
    } 
    catch(e) 
    {
      // caso ocorra algum erro na requisição
      return 'Erro na conexão: $e';  
    }
  }

  // Atualiza produto
  Future<String> atualizarProduto(Map<String, dynamic> produto) async 
  {
    var url = Uri.parse('http://localhost:8080/apiProdutos/atualizarProdutos'); // Use o IP correto

    try 
    {
      final response = await http.put
      (
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(produto),
      );

      if(response.statusCode == 200) 
      {
        return "Produto atualizado com SUCESSO!";
      } 
      else if(response.statusCode == 404) 
      {
        return "Produto não encontrado.";
      } 
      else 
      {
        return "Erro ao atualizar produto: ${response.statusCode}";
      }
    } 
    catch (e) 
    {
      return "Erro na conexão: $e";
    }
  }

  // busca e atualiza o estado
  void buscarProdutosFunc() async 
  {
    setState(() {
      // inicia o carregamento
      _isLoading = true; 
    });

    String valor = controlaTexto.text.trim();

    if(valor.isEmpty) 
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, insira um valor para busca.')));

      setState(() {
        // para o carregamento se não houver valor
        _isLoading = false; 
      });

      return;
    }

    String resultado = await buscarProdutos(_buscarPorCodigo ? 'codigo' : 'nome', valor);

    setState(() {
      // para o carregamento após a busca
      _isLoading = false; 
    });

    if(resultado.startsWith('Erro')) 
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)));
    } 
    else 
    {
      var produtosRetornados = jsonDecode(resultado);

      // verifica se encontrou produtos
      if(produtosRetornados.isEmpty) 
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nenhum produto encontrado para "$valor".')));
      } 
      else 
      {
        setState(() {
          produtos = produtosRetornados;
          // exibe a tabela com os produtos encontrados
          _showProdutoTable = true; 
        });
      }
    }
  }


  // Atualiza produto
  void atualizarProdutoFunc(Map<String, dynamic> produto) async 
  {
    String resultado = await atualizarProduto(produto);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)),);

    if(resultado.contains("sucesso")) 
    {
      buscarProdutosFunc();
    }
  }

  // Exibe o diálogo de atualização
  void mostrarDialogoAtualizar(Map<String, dynamic> produto) 
  {
    TextEditingController nomeController = TextEditingController(text: produto['nome']);
    TextEditingController precoController = TextEditingController(text: produto['preco'].toString());
    TextEditingController quantidadeController = TextEditingController(text: produto['quantidade'].toString());

    showDialog
    (
      context: context,
      builder: (context) 
      {
        return AlertDialog
        (
          title: Text('Atualizar Produto', style: TextStyle(fontFamily: "Space_Grotesk", color: Colors.cyan[300])),
          content: SingleChildScrollView
          (
            child: Column
            (
              children: 
              [
                TextField
                (
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  style: TextStyle(fontFamily: "Space_Grotesk"),
                ),

                SizedBox(height: 15,),

                TextField
                (
                  controller: precoController,
                  decoration: InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: "Space_Grotesk"),
                ),

                SizedBox(height: 15,),

                TextField
                (
                  controller: quantidadeController,
                  decoration: InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: "Space_Grotesk"),
                ),
              ],
            ),
          ),
          actions: 
          [
            TextButton
            (
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(fontFamily: "Space_Grotesk"),),
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.cyan[300],
              ),
            ),

            ElevatedButton
            (
              onPressed: () {
                Map<String, dynamic> produtoAtualizado = 
                {
                  "codigo": produto['codigo'],
                  "nome": nomeController.text,
                  "preco": double.tryParse(precoController.text) ?? produto['preco'],
                  "quantidade": int.tryParse(quantidadeController.text) ?? produto['quantidade'],
                };
                atualizarProdutoFunc(produtoAtualizado);
                buscarProdutosFunc();
                Navigator.of(context).pop();
              },
              child: Text('Atualizar', style: TextStyle(fontFamily: "Space_Grotesk")),
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.cyan[300],
              ),
            ),
          ],
        );
      },
    );
  }

  // Excluir produto
  Future<String> excluirProduto(int codigo) async 
  {
    var url = Uri.parse('http://localhost:8080/apiProdutos/removerProduto/$codigo');

    try 
    {
      final response = await http.delete(url, headers: {'Content-Type': 'application/json; charset=UTF-8'},);

      if(response.statusCode == 200) 
      {
        return "Produto excluído com SUCESSO!";
      } 
      else 
      {
        return "Erro ao excluir produto: ${response.statusCode}";
      }
    } 
    catch(e) 
    {
      return "Erro na conexão: $e";
    }
  }

  void mostrarDialogoExcluir(int codigo) 
  {
    showDialog
    (
      context: context,
      builder: (context) 
      {
        return AlertDialog(
          title: Text('Excluir Produto', style: TextStyle(fontFamily: "Space_Grotesk", color: Colors.red[300])),
          content: Text('Tem certeza de que deseja excluir este produto?', style: TextStyle(fontFamily: "Space_Grotesk")),
          actions: 
          [
            TextButton
            (
              onPressed: () {
                Navigator.of(context).pop(); // fecha/cancela
              },
              child: Text('Cancelar', style: TextStyle(fontFamily: "Space_Grotesk")),
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.cyan[300],
              ),
            ),

            ElevatedButton
            (
              onPressed: () async {
                String resultado = await excluirProduto(codigo);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)));
                if (resultado.contains("SUCESSO")) 
                {
                  // recarrega a lista de produtos após a exclusão
                  buscarProdutosFunc(); 
                }
                Navigator.of(context).pop();
              },
              child: Text('Excluir', style: TextStyle(fontFamily: "Space_Grotesk")),
              style: ElevatedButton.styleFrom
              (
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.cyan[300],
              ),
            ),
          ],
        );
      },
    );
  }

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
                      labelStyle: TextStyle(fontFamily: "Space_Grotesk"),
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      suffixIcon: IconButton
                      (
                        icon: Icon(Icons.swap_horiz, color: Colors.cyan),
                        onPressed: () {
                          setState(() {
                            _buscarPorCodigo = !_buscarPorCodigo;
                            controlaTexto.clear();
                            // esconde a tabela ao trocar o tipo de busca (nome => codigo, ou vice versa)
                            _showProdutoTable = false; 
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

            if(_showProdutoTable)
              SingleChildScrollView
              (
                scrollDirection: Axis.horizontal,
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.cyan, width: 2),
                  ),
                  child: DataTable
                  (
                    columnSpacing: 16.0,
                    dataRowHeight: 50.0,
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan[100]!),
                    columns: 
                    [
                      DataColumn(label: Text('Código', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Nome', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Preço', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Quantidade', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Atualizar', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Excluir', style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold))),
                    ],
                    rows: produtos.map<DataRow>((produto) 
                    {
                      return DataRow
                      (
                        cells: 
                        [
                          DataCell(Text(produto['codigo'].toString(), style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell(Text(produto['nome'] ?? '', style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell(Text('R\$ ${produto['preco'].toStringAsFixed(2)}', style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell(Text(produto['quantidade'].toString(), style: TextStyle(fontFamily: "Space_Grotesk"))),
                          DataCell
                          (
                            IconButton
                            (
                              icon: Icon(Icons.edit, color: Colors.cyan),
                              onPressed: () {
                                mostrarDialogoAtualizar(produto);
                              },
                            )
                          ),

                          DataCell
                          (
                            IconButton
                            (
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                mostrarDialogoExcluir(produto['codigo']);
                              },
                            )
                          ),
                        ],
                      );
                    }).toList(),

                  ),
                ),
              ),

            SizedBox(height: 20),

            ElevatedButton
            (
              // desabilita o botão durante o carregamento
              onPressed: _isLoading ? null : buscarProdutosFunc, 
              child: Row
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  if (_isLoading) 
                    Padding
                    (
                      padding: const EdgeInsets.only(right: 2.0), 
                      child: CircularProgressIndicator
                      (
                        // cor do indicador de carregamento
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white), 
                        strokeWidth: 0.5,
                      ),
                    ),
                    
                    // Texto que muda conforme o estado
                    Text(_isLoading ? 'Carregando...' : 'Consultar Produto'), 
                  ],
                ), style: ElevatedButton.styleFrom
                  (
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
            )
          ],
        ),
      ),
    );
  }
}
