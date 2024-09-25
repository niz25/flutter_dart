// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:sysale/_cadastrofunc.dart';
import 'package:sysale/string_extension.dart';
import '_cadastroprod.dart';
import '_cadastrofunc.dart';

class FuncionarioFormWidget extends StatefulWidget {
  @override
  _FuncionarioFormWidgetState createState() => _FuncionarioFormWidgetState();
}

class _FuncionarioFormWidgetState extends State<FuncionarioFormWidget> {
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaEmail = TextEditingController();
  TextEditingController controlaCfp = TextEditingController();
  List<CadastroFunc> listaFunc = [];
  GlobalKey<FormState> chaveValidacao = GlobalKey();

  //Validação
  ValueNotifier<bool> nomeValido = ValueNotifier(true);
  ValueNotifier<bool> emailValido = ValueNotifier(true);
  ValueNotifier<bool> cpfValido = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  fontFamily: "Space_Grotesk", // Adicionando fontFamily
                ),
              ),
              SizedBox(height: 25),
              ValueListenableBuilder(
                valueListenable: nomeValido,
                builder: (context, value, child) {
                  return TextFormField(
                    keyboardType: TextInputType.name,
                    controller: controlaNome,
                    decoration: InputDecoration(
                      label: Text("Nome Completo", style: TextStyle(fontFamily: "Space_Grotesk"),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      errorText:
                          value ? null : "Preencha o campo com um nome válido",
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
                          return word[0].toUpperCase() +
                              word.substring(1).toLowerCase();
                        } else {
                          return '';
                        }
                      }).join(' '); // Junte as palavras novamente
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
                valueListenable: cpfValido,
                builder: (context, value, child) {
                  return TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controlaCfp,
                    decoration: InputDecoration(
                      label: Text("CPF", style: TextStyle(fontFamily: "Space_Grotesk"),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      errorText:
                          value ? null : "Preencha o campo com um CPF válido",
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      errorText: value
                          ? null
                          : "Preencha o campo com um e-mail válido",
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
                      emailValido.value = value.isNotEmpty &&
                          value.contains('@') &&
                          value.contains('.com');
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  bool isNomeValid = controlaNome.text.isNotEmpty &&
                      controlaNome.text.length >= 3;
                  bool isEmailValid = controlaEmail.text.isNotEmpty &&
                      controlaEmail.text.contains('@') &&
                      controlaEmail.text.contains('.com');
                  bool isCpfValid = controlaCfp.text.isNotEmpty &&
                      controlaCfp.text.length == 11;

                  setState(() {
                    nomeValido.value = isNomeValid;
                    emailValido.value = isEmailValid;
                    cpfValido.value = isCpfValid;
                  });

                  bool isCpfCadastrado = listaFunc.any(
                    (func) => func.cpf == int.parse(controlaCfp.text),
                  );

                  if (isCpfCadastrado) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(children: [
                            Icon(Icons.error),
                            SizedBox(
                              width: 5,
                            ),
                            Text('ERRO', style: TextStyle(fontFamily: "Space_Grotesk")),
                          ]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'O funcionário não foi cadastrado! Já existe um funcionário com esse CPF.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, fontFamily: "Space_Grotesk"),
                              ),
                              SizedBox(height: 20),
                              Image.asset('assets/images/error.png', height: 150, width: 150),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  if (isNomeValid && isEmailValid && isCpfValid) {
                    int cpf = int.parse(controlaCfp.text);
                    String nome = controlaNome.text;
                    String email = controlaEmail.text;
                    CadastroFunc cf = CadastroFunc(nome, cpf, email);
                    listaFunc.add(cf);
                    mostrarFunc();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.check),
                              SizedBox(width: 5),
                              Text('Funcionário Cadastrado!', style: TextStyle(fontFamily: "Space_Grotesk")),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'O funcionário foi cadastrado com sucesso!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, fontFamily: "Space_Grotesk"),
                              ),
                              SizedBox(height: 20),
                              Image.asset('assets/images/check.png', height: 150, width: 150),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    setState(() {});
                    controlaNome.clear();
                    controlaEmail.clear();
                    controlaCfp.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.cyan[300],
                ),
                child: Text(
                  "Cadastrar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk"), // Adicionando fontFamily
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void mostrarFunc() {
    print("FUNCIONÁRIOS CADASTRADOS: \n\n");
    listaFunc.forEach((CadastroFunc f) {
      print("--------------------------------------------");
      print("Nome Completo = " + f.nome);
      print("CPF = " + f.cpf.toString());
      print("E-mail = " + f.email);
    });
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
  List<CadastroProd> listaProd = [];
  GlobalKey<FormState> chaveValidacao = GlobalKey();

  //validação
  ValueNotifier<bool> codValido = ValueNotifier(true);
  ValueNotifier<bool> nomeValido = ValueNotifier(true);
  ValueNotifier<bool> precoValido = ValueNotifier(true);
  ValueNotifier<bool> qtdeValido = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            key: chaveValidacao,
            children: [
              Column(
                children: [
                  Text(
                    "Cadastro de Produtos",
                    style: TextStyle(
                      color: Color.fromARGB(255, 69, 181, 196),
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Space_Grotesk", // Adicionando fontFamily
                    ),
                  ),
                  SizedBox(height: 25),
                  ValueListenableBuilder(
                    valueListenable: codValido,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: controlaCod,
                        decoration: InputDecoration(
                          label: Text("Código", style: TextStyle(fontFamily: "Space_Grotesk"),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                          label: Text("Nome", style: TextStyle(fontFamily: "Space_Grotesk"),),
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
                          label: Text("Preço", style: TextStyle(fontFamily: "Space_Grotesk"),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                          label: Text("Quantidade", style: TextStyle(fontFamily: "Space_Grotesk"),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                    onPressed: () {
                      bool isCodValid = controlaCod.text.isNotEmpty;
                      bool isNomeValid = controlaNome.text.isNotEmpty && controlaNome.text.length >= 3;
                      bool isPrecoValid = controlaPreco.text.isNotEmpty;
                      bool isQtdeValid = controlaQtde.text.isNotEmpty;

                      setState(() {
                        codValido.value = isCodValid;
                        nomeValido.value = isNomeValid;
                        precoValido.value = isPrecoValid;
                        qtdeValido.value = isQtdeValid;
                      });

                      bool isCodCadastrado = listaProd.any((produto) => produto.cod == int.parse(controlaCod.text));

                      if (isCodCadastrado) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(Icons.error),
                                  SizedBox(width: 5),
                                  Text('ERRO', style: TextStyle(fontFamily: "Space_Grotesk")),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'O produto não foi cadastrado! Já existe um produto com esse código.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, fontFamily: "Space_Grotesk"),
                                  ),
                                  SizedBox(height: 20),
                                  Image.asset('assets/images/error.png', height: 150, width: 150),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }

                      bool isNomeCadastrado = listaProd.any((produto) => produto.nome == controlaNome.text);

                      if (isNomeCadastrado) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(children: [
                                Icon(Icons.error),
                                SizedBox(width: 5),
                                Text('ERRO', style: TextStyle(fontFamily: "Space_Grotesk")),
                              ]),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'O produto não foi cadastrado! Já existe um produto com esse nome.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, fontFamily: "Space_Grotesk"),
                                  ),
                                  SizedBox(height: 20),
                                  Image.asset('assets/images/error.png', height: 150, width: 150),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }

                      if (isCodValid && isNomeValid && isPrecoValid && isQtdeValid) {
                        int cod = int.parse(controlaCod.text);
                        String nome = controlaNome.text;
                        double preco = double.parse(controlaPreco.text);
                        int qtde = int.parse(controlaQtde.text);
                        CadastroProd cp = CadastroProd(cod, nome, preco, qtde);
                        listaProd.add(cp);
                        mostrarPro();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(Icons.check),
                                  SizedBox(width: 5),
                                  Text('Produto Cadastrado!', style: TextStyle(fontFamily: "Space_Grotesk")),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'O produto foi cadastrado com sucesso!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, fontFamily: "Space_Grotesk"),
                                  ),
                                  SizedBox(height: 20),
                                  Image.asset('assets/images/check.png', height: 150, width: 150),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        setState(() {});
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
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  void mostrarPro() {
    print("PRODUTOS CADASTRADOS: \n\n");
    listaProd.forEach((CadastroProd p) {
      print("--------------------------------------------");
      print("Código = " + p.cod.toString());
      print("Nome = " + p.nome);
      print("Preço = " + p.preco.toString() + " reais");
      print("Quantidade = " + p.qtde.toString() + " unidades");
    });
  }
}
