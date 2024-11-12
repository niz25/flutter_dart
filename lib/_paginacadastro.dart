// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:sysale/_cadastrofunc.dart';
import 'package:sysale/string_extension.dart';
import '_cadastroprod.dart';
import '_cadastrofunc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FuncionarioFormWidget extends StatefulWidget {
  @override
  _FuncionarioFormWidgetState createState() => _FuncionarioFormWidgetState();
}

class _FuncionarioFormWidgetState extends State<FuncionarioFormWidget> {
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaEmail = TextEditingController();
  TextEditingController controlaCfp = TextEditingController();
  GlobalKey<FormState> chaveValidacao = GlobalKey<FormState>();

  // Validação
  ValueNotifier<bool> nomeValido = ValueNotifier(true);
  ValueNotifier<bool> emailValido = ValueNotifier(true);
  ValueNotifier<bool> cpfValido = ValueNotifier(true);

  CadastroFunc cadfunc = CadastroFunc();

  /*Future<String> salvarBD() async {
    var url = Uri.parse('http://localhost:8080/apiFuncionario/inserirFuncionarios');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "cpf": cadfunc.cpf,
          "nome": cadfunc.nome,
          "email": cadfunc.email
        }),
      );

      if (response.statusCode == 200) {
        return "Funcionário cadastrado com SUCESSO!";
      } else {
        return "Erro ao salvar funcionário: ${response.body}";
      }
    } catch (e) {
      return "Erro ao salvar funcionário: $e";
    }
  }*/

  Future<String> salvarBD() async {
  var url = Uri.parse('http://localhost:8080/apiFuncionario/inserirFuncionarios');
  
  // Verificar se o CPF é válido antes de enviar a requisição
  if (cadfunc.cpf.isEmpty || cadfunc.nome.isEmpty || cadfunc.email.isEmpty) {
    return "Por favor, preencha todos os campos obrigatórios!";
  }

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        "cpf": cadfunc.cpf,  // Assegure-se de que o CPF é uma String
        "nome": cadfunc.nome,
        "email": cadfunc.email
      }),
    );

    if (response.statusCode == 200) {
      return "Funcionário cadastrado com SUCESSO!";
    } else {
      // Melhorar a mensagem de erro com o conteúdo da resposta
      return "Erro ao salvar funcionário: ${response.body}";
    }
  } catch (e) {
    return "Erro ao salvar funcionário: $e";
  }
}


  Future<bool> verificarFuncionarioExistente(String cpf) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/apiFuncionario/funcionarios/cpf/$cpf'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data != null && data['cpf'] == cpf;
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error in verificarFuncionarioExistente: $e");
      return false;
    }
  }

  // Função para deixar as iniciais de cada palavra em maiúsculas
  String formatarNome(String nome) {
    return nome
        .split(' ')
        .map((palavra) => palavra.isNotEmpty ? '${palavra[0].toUpperCase()}${palavra.substring(1).toLowerCase()}' : '')
        .join(' ');
  }

  void _showDialog(String title, String message, IconData icon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Row(
          children: [
            Icon(icon, color: title == "ERRO" ? Colors.red : Colors.green),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: chaveValidacao,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  "Cadastro de Funcionários",
                  style: TextStyle(
                    color: Color.fromARGB(255, 69, 181, 196),
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Space_Grotesk",
                  ),
                ),
                SizedBox(height: 25),
                // Campo Nome
                ValueListenableBuilder(
                  valueListenable: nomeValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      keyboardType: TextInputType.name,
                      controller: controlaNome,
                      decoration: InputDecoration(
                        label: Text("Nome Completo", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um nome válido",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome.';
                        }
                        if (value.length < 3) {
                          return 'O nome deve ter pelo menos 3 caracteres.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controlaNome.text = formatarNome(value);
                        controlaNome.selection = TextSelection.fromPosition(TextPosition(offset: controlaNome.text.length));
                        nomeValido.value = value.isNotEmpty && value.length >= 3;
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                // Campo CPF
                ValueListenableBuilder(
                  valueListenable: cpfValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controlaCfp,
                      decoration: InputDecoration(
                        label: Text("CPF", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um CPF válido",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF.';
                        }
                        if (value.length != 11) {
                          return 'O CPF deve ter 11 dígitos.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        cpfValido.value = value.isNotEmpty && value.length == 11;
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                // Campo E-mail
                ValueListenableBuilder(
                  valueListenable: emailValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: controlaEmail,
                      decoration: InputDecoration(
                        label: Text("E-mail", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um e-mail válido",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o e-mail.';
                        }
                        if (!value.contains('@') || !value.contains('.com')) {
                          return 'Por favor, insira um e-mail válido.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        emailValido.value = value.isNotEmpty && value.contains('@') && value.contains('.com');
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (chaveValidacao.currentState!.validate()) {
                      bool funcionarioExistente = await verificarFuncionarioExistente(controlaCfp.text);
                      if (funcionarioExistente) {
                        _showDialog("ERRO", "Funcionário já cadastrado com esse CPF", Icons.error);
                        return;
                      }

                      cadfunc.cpf = controlaCfp.text;
                      cadfunc.nome = controlaNome.text;
                      cadfunc.email = controlaEmail.text;

                      String mensagem = await salvarBD();
                      if (mensagem.startsWith("Erro")) {
                        _showDialog("ERRO", mensagem, Icons.error);
                      } else {
                        _showDialog("Sucesso", mensagem, Icons.check);
                      }

                      controlaCfp.clear();
                      controlaNome.clear();
                      controlaEmail.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ProdutoFormWidget extends StatefulWidget {
  @override
  _ProdutoFormWidgetState createState() => _ProdutoFormWidgetState();
}

class _ProdutoFormWidgetState extends State<ProdutoFormWidget> {
  TextEditingController controlaCod = TextEditingController();
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaQtde = TextEditingController();
  TextEditingController controlaPreco = TextEditingController();
  GlobalKey<FormState> chaveValidacao = GlobalKey<FormState>();

  //validação
  ValueNotifier<bool> codValido = ValueNotifier(true);
  ValueNotifier<bool> nomeValido = ValueNotifier(true);
  ValueNotifier<bool> precoValido = ValueNotifier(true);
  ValueNotifier<bool> qtdeValido = ValueNotifier(true);

  CadastroProd cadprod = CadastroProd();

  // Função para salvar no banco
  Future<String> salvarBD() async
  {
    var url = Uri.parse('http://localhost:8080/apiProdutos/inserirProdutos');
    try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        "codigo": cadprod.cod,
        "nome": cadprod.nome,
        "quantidade": cadprod.qtde,
        "preco": cadprod.preco
      }),
    );

     // Verifique o status da resposta
    if (response.statusCode == 200) {
      return "Produto cadastrado com sucesso!"; // Mensagem de sucesso
    } else {
      return "Erro ao salvar produto: ${response.body}"; // Mensagem de erro
    }
  } catch (e) {
    return "Erro ao salvar produto: $e"; // Mensagem de erro
  }
  }

  Future<bool> verificarProdutoExistente(String codigo, String nome) async {
  try {
    final response = await http.get(Uri.parse('http://localhost:8080/apiProdutos/produtos/codigo/$codigo'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      // Ensure 'codigo' and 'nome' keys exist in the response data
      if (data != null && data.containsKey('codigo') && data.containsKey('nome')) {
        return data['codigo'] == codigo || data['nome'] == nome;
      } else {
        print("Unexpected data format: $data");
        return false;
      }
    } else {
      print("Failed to fetch product. Status code: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error in verificarProdutoExistente: $e");
    return false;
  }
}

  void _showDialog(String title, String message, IconData icon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Row(
          children: [
            Icon(icon, color: title == "ERRO" ? Colors.red : Colors.green),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: chaveValidacao,
            child: Column(
              children: [
                Text("Cadastro de Produtos", style: TextStyle(color: Color.fromARGB(255, 69, 181, 196), fontSize: 25, fontWeight: FontWeight.w400, fontFamily: "Space_Grotesk")),
                SizedBox(height: 25),
                
                ValueListenableBuilder(
                  valueListenable: codValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: controlaCod,
                      decoration: InputDecoration(
                        label: Text("Código", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um código válido",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value!.isEmpty) {
                          return 'Por favor, insira o código.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        codValido.value = value.isNotEmpty;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                ValueListenableBuilder(
                  valueListenable: nomeValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.name,
                      controller: controlaNome,
                      decoration: InputDecoration(
                        label: Text("Nome", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um nome válido",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome.';
                        }
                        if (value.length < 3) {
                          return 'O nome deve ter pelo menos 3 caracteres.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        String capitalizeText = value.split(' ').map((word) {
                          if (word.isNotEmpty) {
                            return word[0].toUpperCase() + word.substring(1).toLowerCase();
                          } else {
                            return '';
                          }
                        }).join(' ');
                        controlaNome.value = TextEditingValue(
                          text: capitalizeText,
                          selection: controlaNome.selection,
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                ValueListenableBuilder(
                  valueListenable: precoValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: controlaPreco,
                      decoration: InputDecoration(
                        label: Text("Preço", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um preço válido",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o preço';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        precoValido.value = value.isNotEmpty;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                ValueListenableBuilder(
                  valueListenable: qtdeValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: controlaQtde,
                      decoration: InputDecoration(
                        label: Text("Quantidade", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com uma quantidade válida",
                      ),
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a quantidade';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        qtdeValido.value = value.isNotEmpty;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
    if (chaveValidacao.currentState!.validate()) {
      // Verifique se o produto já existe
      bool produtoExistente = await verificarProdutoExistente(controlaCod.text, controlaNome.text);
      if (produtoExistente) {
        _showDialog("ERRO", "Produto já cadastrado com esse código ou nome!", Icons.error);
        return;
      }

      // Defina os dados e salve no banco de dados via API
      cadprod.cod = int.parse(controlaCod.text);
      cadprod.nome = controlaNome.text;
      cadprod.qtde = int.parse(controlaQtde.text);
      cadprod.preco = double.parse(controlaPreco.text);

      String mensagem = await salvarBD(); // Chame o método que agora retorna uma mensagem

      // Verifique se a mensagem contém "Erro" para determinar o título do diálogo
      if (mensagem.startsWith("Erro")) {
        _showDialog("ERRO", mensagem, Icons.error);
      } else {
        _showDialog("Sucesso", mensagem, Icons.check);
      }

      // Limpar os campos após a operação
      controlaCod.clear();
      controlaNome.clear();
      controlaPreco.clear();
      controlaQtde.clear();
    }
  },

                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk"),
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica para o botão scanner
                  },
                  label: Text("Scanner", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk")),
                  icon: Icon(Icons.qr_code_scanner, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
