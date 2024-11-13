// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors, sort_child_properties_last
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

  // validação
  ValueNotifier<bool> nomeValido = ValueNotifier(true);
  ValueNotifier<bool> emailValido = ValueNotifier(true);
  ValueNotifier<bool> cpfValido = ValueNotifier(true);

  CadastroFunc cadfunc = CadastroFunc();

  Future<String> salvarBD() async 
  {
    var url = Uri.parse('http://localhost:8080/apiFuncionario/inserirFuncionarios');
    
    try 
    {
      final response = await http.post
      (
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "cpf": cadfunc.cpf,  
          "nome": cadfunc.nome,
          "email": cadfunc.email
        }),
      );

      if(response.statusCode == 200) 
      {
        return "Funcionário cadastrado com SUCESSO!";
      } 
      else 
      {
        return "${response.body}";
      }
    } 
    catch(e) 
    {
      return "Erro ao salvar funcionário: $e";
    }
  }

  Future<bool> verificarFuncionarioExistente(String cpf) async 
  {
    try 
    {
      final response = await http.get(Uri.parse('http://localhost:8080/apiFuncionario/funcionarios/cpf/$cpf'));

      if(response.statusCode == 200) 
      {
        final data = jsonDecode(response.body);
        
        if(data != null && data['cpf'] == cpf) 
        {
          return true; 
        } 
        else 
        {
          print("Funcionário não encontrado ou formato inesperado: $data");
          return false;
        }
      } 
      else {

        print("Erro. Status code: ${response.statusCode}");
        return false;
      }
    } 
    catch(e) 
    {
      print("Erro ao verificar funcionário: $e");
      return false;
    }
  }

  // capitalize
  String formatarNome(String nome) 
  {
    return nome . split(' ') . map((palavra) => palavra.isNotEmpty ? '${palavra[0].toUpperCase()}${palavra.substring(1).toLowerCase()}' : '') . join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Form
    (
      key: chaveValidacao,
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: 
        [
          Padding
          (
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column
            (
              children: 
              [
                Text("Cadastro de Funcionários", style: TextStyle(color: Color.fromARGB(255, 69, 181, 196), fontSize: 25, fontWeight: FontWeight.w400, fontFamily: "Space_Grotesk",),),

                SizedBox(height: 25),

                // NOME
                ValueListenableBuilder
                (
                  valueListenable: nomeValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField
                    (
                      keyboardType: TextInputType.name,
                      controller: controlaNome,
                      decoration: InputDecoration
                      (
                        label: Text("Nome Completo", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder
                        (
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder
                        (
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um nome válido",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value == null || value.isEmpty) 
                        {
                          return 'Por favor, insira o nome.';
                        }
                        if(value.length < 3) 
                        {
                          return 'O nome deve ter pelo menos 3 caracteres.';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        controlaNome.text = formatarNome(value);
                        controlaNome.selection = TextSelection.fromPosition(TextPosition(offset: controlaNome.text.length));
                        nomeValido.value = value.isNotEmpty && value.length >= 3;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                // CPF
                ValueListenableBuilder
                (
                  valueListenable: cpfValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField
                    (
                      keyboardType: TextInputType.number,
                      controller: controlaCfp,
                      decoration: InputDecoration
                      (
                        label: Text("CPF", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder
                        (
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder
                        (
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um CPF válido",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value == null || value.isEmpty) 
                        {
                          return 'Por favor, insira o CPF.';
                        }
                        if(value.length != 11) 
                        {
                          return 'O CPF deve ter 11 dígitos.';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        cpfValido.value = value.isNotEmpty && value.length == 11;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                // EMAIL
                ValueListenableBuilder
                (
                  valueListenable: emailValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField(
                      controller: controlaEmail,
                      decoration: InputDecoration
                      (
                        label: Text("E-mail", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder
                        (
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder
                        (
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um e-mail válido",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value == null || value.isEmpty) 
                        {
                          return 'Por favor, insira o e-mail.';
                        }
                        if(!value.contains('@') || !value.contains('.com')) 
                        {
                          return 'Por favor, insira um e-mail válido.';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        emailValido.value = value.isNotEmpty && value.contains('@') && value.contains('.com');
                      },
                    );
                  },
                ),

                SizedBox(height: 20),
                
                ElevatedButton
                (
                  onPressed: () async
                  {
                    if(chaveValidacao.currentState!.validate()) 
                    {
                      bool funcionarioExistente = await verificarFuncionarioExistente(controlaCfp.text);
                      if(funcionarioExistente) 
                      {
                        ScaffoldMessenger.of(context).showSnackBar
                        (
                          SnackBar(content: Text("Funcionário já cadastrado com esse CPF!"))
                        );
                        return;
                      }

                      cadfunc.cpf = controlaCfp.text;
                      cadfunc.nome = controlaNome.text;
                      cadfunc.email = controlaEmail.text;

                      String mensagem = await salvarBD();

                      ScaffoldMessenger.of(context).showSnackBar
                      (
                        SnackBar(content: Text(mensagem))
                      );

                      controlaCfp.clear();
                      controlaNome.clear();
                      controlaEmail.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom
                  (
                    padding: EdgeInsets.all(20.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
                  child: Text("Cadastrar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// -----------------------------------------------------------------------------------------------------------------------

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

  // validação
  ValueNotifier<bool> codValido = ValueNotifier(true);
  ValueNotifier<bool> nomeValido = ValueNotifier(true);
  ValueNotifier<bool> precoValido = ValueNotifier(true);
  ValueNotifier<bool> qtdeValido = ValueNotifier(true);

  CadastroProd cadprod = CadastroProd();

  // salva no banco
  Future<String> salvarBD() async 
  {
    var url = Uri.parse('http://localhost:8080/apiProdutos/inserirProdutos');
    try 
    {
      final response = await http.post
      (
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "codigo": cadprod.cod,
          "nome": cadprod.nome,
          "quantidade": cadprod.qtde,
          "preco": cadprod.preco
        }),
      );

      if(response.statusCode == 200)
      {
        return "Produto cadastrado com sucesso!";
      } 
      else {
        return "${response.body}";
      }
    } 
    catch(e) 
    {
      return "Erro ao salvar produto: $e"; 
    }
  }

  Future<bool> verificarProdutoExistente(String codigo, String nome) async 
  {
    try 
    {
      final response = await http.get(Uri.parse('http://localhost:8080/apiProdutos/produtos/codigo/$codigo'));

      if(response.statusCode == 200) 
      {
        final data = jsonDecode(response.body);

        // verifica se código e nome existem
        if(data != null && data.containsKey('codigo') && data.containsKey('nome')) 
        {
          return data['codigo'] == codigo || data['nome'] == nome;
        } 
        else 
        {
          print("Formato inesperado: $data");
          return true;
        }
      } 
      else 
      {
        print("Erro. Status code: ${response.statusCode}");
        return false;
      }
    } 
    catch(e) 
    {
      print("Erro em verificar produto: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: 
      [
        Padding
        (
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form
          (
            key: chaveValidacao,
            child: Column
            (
              children: 
              [
                Text("Cadastro de Produtos", style: TextStyle(color: Color.fromARGB(255, 69, 181, 196), fontSize: 25, fontWeight: FontWeight.w400, fontFamily: "Space_Grotesk")),
                SizedBox(height: 25),
                
                // CÓDIGO
                ValueListenableBuilder
                (
                  valueListenable: codValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField
                    (
                      controller: controlaCod,
                      decoration: InputDecoration
                      (
                        label: Text("Código", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um código válido",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value!.isEmpty)
                        {
                          return 'Por favor, insira o código.';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        codValido.value = value.isNotEmpty;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                // NOME
                ValueListenableBuilder
                (
                  valueListenable: nomeValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.name,
                      controller: controlaNome,
                      decoration: InputDecoration
                      (
                        label: Text("Nome", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um nome válido",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value == null || value.isEmpty) 
                        {
                          return 'Por favor, insira o nome.';
                        }
                        if(value.length < 3) 
                        {
                          return 'O nome deve ter pelo menos 3 caracteres.';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        String capitalizeText = value.split(' ').map((word) 
                        {
                          if(word.isNotEmpty) 
                          {
                            return word[0].toUpperCase() + word.substring(1).toLowerCase();
                          } 
                          else 
                          {
                            return '';
                          }
                        }). join(' ');

                        controlaNome.value = TextEditingValue
                        (
                          text: capitalizeText,
                          selection: controlaNome.selection,
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                // PREÇO
                ValueListenableBuilder
                (
                  valueListenable: precoValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField
                    (
                      controller: controlaPreco,
                      decoration: InputDecoration
                      (
                        label: Text("Preço", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com um preço válido",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value == null || value.isEmpty) 
                        {
                          return 'Por favor, insira o preço';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        precoValido.value = value.isNotEmpty;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                // QUANTIDADE
                ValueListenableBuilder
                (
                  valueListenable: qtdeValido,
                  builder: (context, value, child) 
                  {
                    return TextFormField
                    (
                      controller: controlaQtde,
                      decoration: InputDecoration
                      (
                        label: Text("Quantidade", style: TextStyle(fontFamily: "Space_Grotesk")),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        errorText: value ? null : "Preencha o campo com uma quantidade válida",
                      ),

                      validator: (value) 
                      {
                        value = value?.trim();
                        if(value == null || value.isEmpty) 
                        {
                          return 'Por favor, insira a quantidade';
                        }
                        return null;
                      },

                      onChanged: (value) 
                      {
                        qtdeValido.value = value.isNotEmpty;
                      },
                    );
                  },
                ),

                SizedBox(height: 20),

                ElevatedButton
                (
                  onPressed: () async 
                  {
                    if(chaveValidacao.currentState!.validate()) 
                    {
                      // verifica se o produto já existe
                      bool produtoExistente = await verificarProdutoExistente(controlaCod.text, controlaNome.text);
                      
                      if(produtoExistente) 
                      {
                        ScaffoldMessenger.of(context).showSnackBar
                        (
                          SnackBar(content: Text("Produto já cadastrado com esse código ou nome!"))
                        );
                        return;
                      }
                      else
                      {
                        cadprod.cod = int.parse(controlaCod.text);
                        cadprod.nome = controlaNome.text;
                        cadprod.qtde = int.parse(controlaQtde.text);
                        cadprod.preco = double.parse(controlaPreco.text);

                        controlaNome.clear();
                        controlaCod.clear();
                        controlaPreco.clear();
                        controlaQtde.clear();
                      }

                      String mensagem = await salvarBD(); 

                      ScaffoldMessenger.of(context).showSnackBar
                      (
                        SnackBar(content: Text(mensagem))
                      );

                    }
                  },
                  style: ElevatedButton.styleFrom
                  (
                    padding: EdgeInsets.all(20.0),
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.cyan[300],
                  ),
                  child: Text("Cadastrar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk"),),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
