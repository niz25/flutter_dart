// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sysale/_cadastrar.dart';
import 'package:sysale/atualizar.dart';
import 'package:sysale/bemvindos.dart';
import 'package:sysale/consultar.dart';

class MyHomePage extends StatefulWidget {
  String nome = "";
  MyHomePage(this.nome, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String user = "";
  @override
  Widget build(BuildContext context) {
    // mostra();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text(
          'SySale',
          style: TextStyle(color: Colors.white),
        ),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      //gaveta com opções
      drawer: Drawer(
        //opções
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(69, 181, 196, 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //opções
            ListTile(
              leading: Icon(Icons.app_registration_outlined),
              title: Text('Cadastrar'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCadastro()));
              },
            ),

            ListTile(
              leading: Icon(Icons.pending_actions_rounded),
              title: Text('Atualizar'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAtualizar()));
              },
            ),

            ListTile(              
              leading: Icon(Icons.search),
              title: Text('Consultar'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyConsulta()));
              },
            ),

            Divider(),

            ListTile
            (
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 5),
                          Text('Deseja mesmo sair?'),
                        ],
                      ),
                      content: 
                      SizedBox(height: 150, width: 150, child: Image.asset('assets/images/question.png'),), 
                      actions: [
                      
                        TextButton(
                          onPressed: () {
                            // Fecha o diálogo de confirmação
                            Navigator.of(context).pop();
                            // Faz logout
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyFirstPage()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            'Sim',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                        
                        TextButton(
                          onPressed: () {
                            // Fecha o diálogo de confirmação
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Não',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 95,
                backgroundColor: Color.fromARGB(255, 69, 181, 196),
                backgroundImage: AssetImage('assets/images/home.png'),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bem vindo(a) " + widget.nome + " !",
                      style: TextStyle(
                          color: Color.fromARGB(255, 160, 222, 214),
                          fontSize: 20,
                          fontWeight: FontWeight.w300)),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Divider(),

              SizedBox(
                height: 20,
              ),

              Text("Esse é o sistema de vendas SySale"),

              SizedBox(
                height: 30,
              ),

              //CARD DE CADASTRO
              Card(
                color: Color.fromARGB(255, 250, 255, 253),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                //controla as sombras do card
                elevation: 5,

                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    //define o tamanho principal do widget
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        //cobre todo o espaço disponível com a imagem
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/home1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(
                                color: Color.fromARGB(255, 196, 255, 247))),
                      ),
                      SizedBox(
                        height: 70,
                        child: ListTile(
                          //leading: Image.asset('assets/images/items.png', height: 200,),
                          title: Center(
                            child: Text(
                              "Cadastro",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 160, 222, 214)),
                            ),
                          ),

                          subtitle: Text(
                            "Aqui você pode cadastrar produtos e funcionários.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          //adiciona os botões
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyCadastro()));
                            },
                            child: Text(
                              "Acessar",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  const Color.fromARGB(255, 160, 222, 214)),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(200, 50)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Card(
                color: Color.fromARGB(255, 250, 255, 253),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                //controla as sombras do card
                elevation: 5,

                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    //define o tamanho principal do widget
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        //cobre todo o espaço disponível com a imagem
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/home3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(
                                color: Color.fromARGB(255, 196, 255, 247))),
                      ),
                      SizedBox(
                        height: 70,
                        child: ListTile(
                          //leading: Image.asset('assets/images/items.png', height: 200,),
                          title: Center(
                            child: Text(
                              "Atualizar",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 160, 222, 214)),
                            ),
                          ),

                          subtitle: Text(
                            "Aqui você pode atualizar os dados dos produtos, conforme o necessário",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          //adiciona os botões
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyAtualizar()));
                            },
                            child: Text(
                              "Acessar",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  const Color.fromARGB(255, 160, 222, 214)),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(200, 50)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Card(
                color: Color.fromARGB(255, 250, 255, 253),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                //controla as sombras do card
                elevation: 5,

                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    //define o tamanho principal do widget
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        //cobre todo o espaço disponível com a imagem
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/home2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(
                                color: Color.fromARGB(255, 196, 255, 247))),
                      ),
                      SizedBox(
                        height: 70,
                        child: ListTile(
                          //leading: Image.asset('assets/images/items.png', height: 200,),
                          title: Center(
                            child: Text(
                              "Consultar",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 160, 222, 214)),
                            ),
                          ),

                          subtitle: Text(
                            "Aqui você pode consultar os dados dos produtos, conforme o necessário",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          //adiciona os botões
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyConsulta()));
                            },
                            child: Text(
                              "Acessar",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  const Color.fromARGB(255, 160, 222, 214)),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(200, 50)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              Container(
                color: const Color.fromARGB(255, 235, 235, 235),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 69, 181, 196),
                      backgroundImage:
                          AssetImage('assets/images/profilewoman.png'),
                    ),
                    SizedBox(height: 16),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 69, 181, 196),
                      backgroundImage:
                          AssetImage('assets/images/profilewoman.png'),
                    ),
                    SizedBox(height: 16),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 69, 181, 196),
                      backgroundImage:
                          AssetImage('assets/images/profileman.png'),
                    ),
                    SizedBox(height: 16),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 69, 181, 196),
                      backgroundImage:
                          AssetImage('assets/images/profilewoman.png'),
                    ),
                    SizedBox(height: 16),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 8),
                        Text('Sobre nós'),
                      ],
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*void mostra()
  {
    for(int i=0; i<widget.lista.length; i++)
    {
      user = user + " " + widget.lista[i];
    }
  }*/
}
