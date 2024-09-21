// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:sysale/bemvindos.dart';

class MyPassword extends StatefulWidget {
  const MyPassword({super.key});

  @override
  State<MyPassword> createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  TextEditingController controlaEmail = TextEditingController();
  GlobalKey<FormState> chaveValidacao = GlobalKey();
  ValueNotifier<bool> emailValido = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => MyFirstPage()));
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Center(
          child: Form(
            key: chaveValidacao,
            child: Column(
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset('assets/images/forgotpassword.png'),
                ),
                Title(
                  color: Colors.cyan,
                  child: Text(
                    "Esqueceu a Senha?",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.cyan,
                      fontFamily: "Space_Grotesk", // Adicionando fontFamily
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Informe o e-mail e inviaremos um código de verificação: ",
                  style: TextStyle(fontFamily: "Space_Grotesk"), // Adicionando fontFamily
                ),
                SizedBox(height: 25),
                ValueListenableBuilder(
                  valueListenable: emailValido,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: controlaEmail,
                      decoration: InputDecoration(
                        label: Text("E-mail"),
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
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    bool isEmailValid = controlaEmail.text.isNotEmpty &&
                        controlaEmail.text.contains('@') &&
                        controlaEmail.text.contains('.com');

                    setState(() {
                      emailValido.value = isEmailValid;
                    });

                    if (isEmailValid) {
                      String email = controlaEmail.text;

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(Icons.check),
                                SizedBox(width: 5),
                                Text('Enviado!', style: TextStyle(fontFamily: "Space_Grotesk")), // Adicionando fontFamily
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'O código foi enviado com sucesso!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, fontFamily: "Space_Grotesk"), // Adicionando fontFamily
                                ),
                                SizedBox(height: 20), // Espaçamento entre o texto e a imagem
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
                                  style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"), // Adicionando fontFamily
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      setState(() {});
                      controlaEmail.clear();
                    }
                    print("Email: " + controlaEmail.text);
                  },
                  child: Text(
                    "Enviar",
                    style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk"), // Adicionando fontFamily
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[300],
                    minimumSize: Size(200, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
