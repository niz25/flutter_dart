import 'package:flutter/material.dart';
import 'package:sysale/esqueceuSenha.dart';
import 'package:sysale/home.dart';
import 'package:sysale/users.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  String loginTexto = "";
  int senhaTexto = 0;
  late FocusNode _loginFocusNode = FocusNode();
  late FocusNode _senhaFocusNode = FocusNode();
  bool _showLoginClearIcon = false;
  bool _showSenhaClearIcon = false;
  bool _showPassword = false;
  late TextEditingController _senhaController;
  TextEditingController controlaLoginTexto = TextEditingController();
  TextEditingController controlaSenhaTexto = TextEditingController();
  Color textColor = Colors.blue[200]!;
  GlobalKey<FormState> chaveValidacao = GlobalKey();
  List<Usuarios> listaUser = [];
  ValueNotifier<bool> loginValido = ValueNotifier(true);
  ValueNotifier<bool> senhaValida = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _senhaController = TextEditingController();

    listaUser = [
      Usuarios("dani_", 12345678, false),
      Usuarios("sysale", 987654321, true),
    ];
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    _senhaFocusNode.dispose();
    _senhaController.dispose();
    controlaLoginTexto.dispose();
    controlaSenhaTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: chaveValidacao,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 550,
                child: Image.asset('assets/images/login.png'),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  focusNode: _loginFocusNode,
                  controller: controlaLoginTexto,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: _showLoginClearIcon && _loginFocusNode.hasFocus
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _showLoginClearIcon = false;
                                _loginFocusNode.unfocus();
                                controlaLoginTexto.clear();
                              });
                            },
                            child: Icon(Icons.clear),
                          )
                        : null,
                    labelText: "Login",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  ),
                  validator: (value) {
                    //value = value?.trim();
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o login.';
                    }
                    if (value.length < 3) {
                      return 'O login deve ter pelo menos 3 caracteres.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    loginValido.value = value.isNotEmpty && value.length < 3;
                    setState(() {
                      _showLoginClearIcon = value.isNotEmpty;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  focusNode: _senhaFocusNode,
                  controller: controlaSenhaTexto,
                  onChanged: (value) {
                    setState(() {
                      _showSenhaClearIcon = value.isNotEmpty;
                    });
                  },
                  obscureText: !_showPassword,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    labelText: "Senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a senha.';
                    }
                    if (value.length < 8) {
                      return 'A senha deve ter pelo menos 8 dígitos.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (chaveValidacao.currentState!.validate()) {
                    loginTexto = controlaLoginTexto.text;
                    senhaTexto = int.parse(controlaSenhaTexto.text);

                    // verifica se o login e a senha correspondem a algum usuário falso
                    bool loginValido = false;
                    for (var user in listaUser) {
                      if (user.login == loginTexto &&
                          user.senha == senhaTexto) {
                        loginValido = true;
                        break;
                      }
                    }
                    if (loginValido) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(Icons.check),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Seja bem-vindo(a) ' + loginTexto + "!"),
                              ],
                            ),
                            content: 
                                SizedBox(height: 150, width: 150, child: Image.asset('assets/images/check.png'),), 
                                
                                
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyHomePage(loginTexto)));
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.cyan),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(Icons.error),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Login ou senha incorretos!'),
                              ],
                            ),
                            content: 
                            SizedBox(height: 150, width: 150, child: Image.asset('assets/images/error.png'),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.cyan),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.cyan[300],
                ),
                child: Text(
                  "Entrar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPassword()));
                  },
                  child: Text(
                    "Esqueceu a senha? Clique aqui",
                    style: TextStyle(color: Colors.cyan[200]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
