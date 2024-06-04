// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sysale/_cadastrar.dart';
import 'package:sysale/bemvindos.dart';
import 'package:sysale/consultar.dart';

class MyHomePage extends StatefulWidget {
  String nome = "";
  MyHomePage(this.nome, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text('SySale', style: TextStyle(color: Colors.white),),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      //gaveta com opções
      drawer: Drawer
      (
        //opções
        child: ListView
        (
          padding: EdgeInsets.zero,
          children: <Widget>
          [
            Container
            (
              height: 80,
              child: DrawerHeader
              (
                decoration: BoxDecoration
                (
                  color: Color.fromRGBO(69, 181, 196, 1),
                ),
                child: Row
                (
                  children: 
                  [
                    Icon(Icons.home, color: Colors.white,),

                    SizedBox(width: 10,),

                    Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24,),),
                  ],
                ),
              ),
            ),

            //opções
            ListTile
            (
              leading: Icon(Icons.app_registration_outlined),
              title: Text('Cadastrar'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCadastro()));
              },
            ),

            ListTile
            (              
              leading: Icon(Icons.search),
              title: Text('Consultar/Atualizar'),
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
                showDialog
                (
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
                      actions: 
                      [
                        TextButton
                        (
                          onPressed: () {
                            // fecha o diálogo de confirmação
                            Navigator.of(context).pop();
                            // faz logout
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyFirstPage()),
                              (route) => false,
                            );
                          },
                          child: Text('Sim', style: TextStyle(color: Colors.cyan),),),
                        
                        TextButton
                        (
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Não', style: TextStyle(color: Colors.cyan),),
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

      body: SingleChildScrollView
      (
        padding: EdgeInsets.all(30),
        child: Center
        (
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              CircleAvatar
              (
                radius: 95,
                backgroundColor: Color.fromARGB(255, 69, 181, 196),
                backgroundImage: AssetImage('assets/images/home.png'),
              ),

              SizedBox(height: 20,),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Text("Bem vindo(a) " + widget.nome + " !", style: TextStyle(color: Color.fromARGB(255, 160, 222, 214), fontSize: 20, fontWeight: FontWeight.w300)),
                ],
              ),

              SizedBox(height: 20,),

              Divider(),

              SizedBox(height: 20,),

              Text("Esse é o sistema de vendas SySale"),

              SizedBox(height: 30,),

              //CARD DE CADASTRO
              Card
              (
                color: Color.fromARGB(255, 250, 255, 253),
                shape: RoundedRectangleBorder
                (
                  borderRadius: BorderRadius.circular(20),
                ),

                //controla as sombras do card
                elevation: 5,

                child: Padding
                (
                  padding: EdgeInsets.all(20),
                  child: Column
                  (
                    //define o tamanho principal do widget
                    mainAxisSize: MainAxisSize.min,
                    children: 
                    [
                      Container
                      (
                        width: 200,
                        height: 200,
                        //cobre todo o espaço disponível com a imagem
                        child: ClipRRect
                        (
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset('assets/images/home1.png', fit: BoxFit.cover,),
                        ),
                        decoration: BoxDecoration
                        (
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all
                            (
                                color: Color.fromARGB(255, 196, 255, 247)
                            ),
                        ),
                      ),

                      SizedBox
                      (
                        height: 70,
                        child: ListTile
                        (
                          title: Center
                          (
                            child: Text("Cadastro", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 160, 222, 214)),),
                          ),

                          subtitle: Text("Aqui você pode cadastrar produtos e funcionários.",textAlign: TextAlign.center,),
                        ),
                      ),

                      SizedBox(height: 50,),

                      ButtonBar
                      (
                        alignment: MainAxisAlignment.center,
                        children: 
                        [
                          //adiciona os botões
                          TextButton
                          (
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyCadastro()));
                            },
                            child: Text("Acessar", style: TextStyle(fontSize: 15, color: Colors.white),),
                            style: ButtonStyle
                            (
                              backgroundColor: MaterialStatePropertyAll
                              (
                                  const Color.fromARGB(255, 160, 222, 214)
                              ),
                              minimumSize: MaterialStatePropertyAll(Size(200, 50)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Card
              (
                color: Color.fromARGB(255, 250, 255, 253),
                shape: RoundedRectangleBorder
                (
                  borderRadius: BorderRadius.circular(20),
                ),

                //controla as sombras do card
                elevation: 5,

                child: Padding
                (
                  padding: EdgeInsets.all(20),
                  child: Column
                  (
                    //define o tamanho principal do widget
                    mainAxisSize: MainAxisSize.min,
                    children: 
                    [
                      Container
                      (
                        width: 200,
                        height: 200,
                        //cobre todo o espaço disponível com a imagem
                        child: ClipRRect
                        (
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset('assets/images/home2.png', fit: BoxFit.cover,),
                        ),
                        decoration: BoxDecoration
                        (
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(
                                color: Color.fromARGB(255, 196, 255, 247))
                        ),
                      ),

                      SizedBox
                      (
                        height: 70,
                        child: ListTile
                        (
                          title: Center
                          (
                            child: Text("Consultar/Atualizar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 160, 222, 214)),),
                          ),

                          subtitle: Text("Aqui você pode consultar os dados dos produtos e atualizar, se for de tua preferência, conforme o necessário.", textAlign: TextAlign.center,),
                        ),
                      ),

                      SizedBox(height: 90,),

                      ButtonBar
                      (
                        alignment: MainAxisAlignment.center,
                        children: 
                        [
                          //adiciona os botões
                          TextButton
                          (
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyConsulta()));
                            },
                            child: Text("Acessar",style: TextStyle(fontSize: 15, color: Colors.white),),

                            style: ButtonStyle
                            (
                              backgroundColor: MaterialStatePropertyAll
                              (
                                  const Color.fromARGB(255, 160, 222, 214)
                              ),
                              minimumSize: MaterialStatePropertyAll(Size(200, 50)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              Divider(),

              SizedBox(height: 30),

              Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                      Icon(Icons.info, color: Color.fromARGB(255, 160, 222, 214),),
                      Text("Sobre Nós", style: TextStyle(color: Color.fromARGB(255, 160, 222, 214), fontSize: 25, fontWeight: FontWeight.bold),),
                      SizedBox(width: 8),
                    ],
                  ),

                  SizedBox(height: 8),

                  Container
                  ( 
                    padding: EdgeInsets.all(8),  
                    child: Text
                    (
                      'Somos criadores do projeto SySale, um sistema de vendas, temos como participantes Daniela, Gonçalo, Maria Eduarda e Heloise. Cada um responsável pelo desenvolvimento do sistema. Daniela é a gerente do projeto, trabalhando como full-stack e designer. Heloise é desenvolvedora front-end e designer. Maria Eduarda é desenvolvedora back-end. Gonçalo é desenvolvedor back-end.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40,),

              Column
              (
                children: 
                [
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: 
                    [
                      Column
                      (
                        children: 
                        [
                          CircleAvatar
                          (
                            radius: 80,
                            backgroundImage: AssetImage("assets/images/dani.jpeg"),
                          ),
                          SizedBox(height: 8),
                          Text("Gerente, Dev. Full-Stack"),
                          Text("e Designer"),
                        ],
                      ),

                      Column
                      (
                        children: 
                        [
                          CircleAvatar
                          (
                            radius: 80,
                            backgroundImage: AssetImage("assets/images/helo.jpeg"),
                          ),
                          SizedBox(height: 8),
                          Text("Dev.Front-end e Designer"),
                        ],
                      ),      
                    ],
                  ),

                  SizedBox(height: 15),

                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: 
                    [
                      Column
                      (
                        children: 
                        [
                          CircleAvatar
                          (
                            radius: 80,
                            backgroundImage: AssetImage("assets/images/duda.jpeg"),
                          ),
                          SizedBox(height: 8),
                          Text("Dev.Back-end"),
                        ],
                      ),

                      Column
                      (
                        children: 
                        [
                          CircleAvatar
                          (
                            radius: 80,
                            backgroundImage: AssetImage("assets/images/gon.jpeg"),
                          ),
                          SizedBox(height: 8),
                          Text("Dev.Back-end"),
                        ],
                      ),
                    ],
                  ),      
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
