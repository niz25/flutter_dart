// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sysale/_cadastrar.dart';
import 'package:sysale/bemvindos.dart';
import 'package:sysale/consultar.dart';
import 'package:sysale/users.dart';

class MyHomePage extends StatefulWidget {
  final String userName;

  const MyHomePage({Key? key, required this.userName}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text("SySale", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "TAN Nimbus",),),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      drawer: Drawer
      (
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
                    Icon(Icons.home, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Space_Grotesk",),),
                  ],
                ),
              ),
            ),

            ListTile
            (
              leading: Icon(Icons.app_registration_outlined),
              title: Text("Cadastrar", style: TextStyle(fontFamily: "Space_Grotesk")),
              onTap: () 
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyCadastro()),);
              },
            ),

            ListTile
            (
              leading: Icon(Icons.search),
              title: Text("Consultar/Atualizar", style: TextStyle(fontFamily: "Space_Grotesk")),
              onTap: () 
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyConsulta()),
                );
              },
            ),

            Divider(),

            ListTile
            (
              leading: Icon(Icons.logout),
              title: Text("Sair", style: TextStyle(fontFamily: "Space_Grotesk")),
              onTap: () 
              {
                showDialog
                (
                  context: context,
                  builder: (context) 
                  {
                    return AlertDialog
                    (
                      title: Row
                      (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                        [
                          Icon(Icons.logout),
                          SizedBox(width: 5),
                          Text("Deseja mesmo sair?", style: TextStyle(fontFamily: "Space_Grotesk")),
                        ],
                      ),
                      content: SizedBox(height: 150, width: 150, child: Image.asset("assets/images/question.png"),),
                      actions:
                      [
                        TextButton
                        (
                          onPressed: () 
                          {
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyFirstPage()),
                              (route) => false,
                            );
                          },
                          child: Text("Sim", style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),),
                        ),

                        TextButton
                        (
                          onPressed: () 
                          {
                            Navigator.of(context).pop();
                          },
                          child: Text("Não",style: TextStyle(color: Colors.cyan, fontFamily: "Space_Grotesk"),),
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

      body: Stack
      (
        children: 
        [
          Container
          (
            decoration: BoxDecoration
            (
              image: DecorationImage
              (
                image: AssetImage("assets/images/fundo_home.png"),
                // preenche a tela inteira
                fit: BoxFit.cover,
              ),
            ),
          ),

          // conteúdo principal a frente da imagem de fundo
          SingleChildScrollView
          (
            padding: EdgeInsets.all(30),
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Image.asset("assets/images/imagem_homepage_top.png", width: 400),

                SizedBox(height: 5),

                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Text("Bem vindo(a) ${widget.userName} !", style: TextStyle(color: Color.fromARGB(255, 160, 222, 214), fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Space_Grotesk",),),
                  ],
                ),

                SizedBox(height: 70),

                Text("O que é SySale?", style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold, fontSize: 20,), textAlign: TextAlign.center,),

                SizedBox(height: 10),

                Text
                (
                  "SySale é um sistema de vendas pensado para satisfazer todos os requisitos que o cliente propõe à nossa equipe. O projeto visa uma maior usabilidade e rapidez, atendendo minuciosamente as exigências predispostas.",
                  style: TextStyle(fontFamily: "Space_Grotesk"),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 50),

                Text("Funções", style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold, fontSize: 20,),textAlign: TextAlign.center,),
                
                SizedBox(height: 30),

                // card de cadastro
                buildCard
                (
                  context, "Cadastro", "Aqui você pode cadastrar produtos e funcionários.","assets/images/home1.png",
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyCadastro()));
                  },
                ),

                SizedBox(height: 30),

                // card de consulta
                buildCard
                (
                  context, "Consultar/Atualizar", "Aqui você pode consultar os dados dos produtos e atualizar, conforme o necessário.", "assets/images/home2.png",
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyConsulta()));
                  },
                ),

                SizedBox(height: 60),

                Text("Sobre Nós", style: TextStyle(fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold, fontSize: 20,), textAlign: TextAlign.center,),

                SizedBox(height: 50),

                //DANIELA
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Flexible
                    (
                      child: ClipRRect
                      (
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/images/dani.jpeg', width: 150, height: 150, fit: BoxFit.cover,),
                      )
                    ),

                    SizedBox(width: 20),

                    Flexible
                    (
                      child: Column
                      (
                        children: 
                        [
                          Text("Daniela Mendonça", style: TextStyle(fontSize: 18, fontFamily: "Space_Grotesk", color: Colors.cyan,), textAlign: TextAlign.justify,),

                          Text("Gerente de Projeto, designer geral e desenvolvedora full-stack. Responsável pelo design e construção da aplicação mobile, e, também, pelo POWERBI.", style: TextStyle(fontSize: 14, fontFamily: "Space_Grotesk", color: Colors.black,), textAlign: TextAlign.center,)
                        ],
                      )
                    ),
                  ],
                ),

                SizedBox(height: 20,),

                Divider(),

                SizedBox(height: 20,),

                // HELOISE
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Flexible
                    (
                      child: Column
                      (
                        children: 
                        [
                          Text("Heloise Kuhl de Oliveira", style: TextStyle(fontSize: 18, fontFamily: "Space_Grotesk", color: Colors.cyan,), textAlign: TextAlign.justify,),

                          Text("Desenvolvedora front-end e designer. Responsável pela construção da aplicação web e pelo design.", style: TextStyle(fontSize: 14, fontFamily: "Space_Grotesk", color: Colors.black,), textAlign: TextAlign.center,)
                        ],
                      )
                    ),

                    SizedBox(width: 20),

                    Flexible
                    (
                      child: ClipRRect
                      (
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/images/helo.jpeg', width: 150, height: 150, fit: BoxFit.cover,),
                      )
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                Divider(),
                SizedBox(height: 20,),

                // GONÇALO
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Flexible
                    (
                      child: ClipRRect
                      (
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/images/gon.jpeg', width: 150, height: 150, fit: BoxFit.cover,),
                      )
                    ),

                    SizedBox(width: 20),

                    Flexible
                    (
                      child: Column
                      (
                        children: 
                        [
                          Text("Gonçalo Henrique da Cruz", style: TextStyle(fontSize: 18, fontFamily: "Space_Grotesk", color: Colors.cyan,), textAlign: TextAlign.justify,),

                          Text("Desenvolvedor back-end. Responsável pela construção e integração da aplicação desktop", style: TextStyle(fontSize: 14, fontFamily: "Space_Grotesk", color: Colors.black,), textAlign: TextAlign.center,)
                        ],
                      )
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                
                Divider(),

                SizedBox(height: 20,),

                // MARIA EDUARDA
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    Flexible
                    (
                      child: Column
                      (
                        children: 
                        [
                          Text("Maria Eduarda Silva Demonte", style: TextStyle(fontSize: 18, fontFamily: "Space_Grotesk", color: Colors.cyan,), textAlign: TextAlign.justify,),

                          Text("Desenvolvedora back-end. Responsável pela construção e integração da aplicação desktop.", style: TextStyle(fontSize: 14, fontFamily: "Space_Grotesk", color: Colors.black,), textAlign: TextAlign.center,)
                        ],
                      )
                    ),

                    SizedBox(width: 20),

                    Flexible
                    (
                      child: ClipRRect
                      (
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/images/duda.jpeg', width: 150, height: 150, fit: BoxFit.cover,),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget buildCard(BuildContext context, String title, String subtitle,
  String imagePath, VoidCallback onPressed) 
  {
    return Card
    (
      color: Color.fromARGB(255, 160, 205, 207).withOpacity(0.5), 
      shape: RoundedRectangleBorder
      (
        borderRadius: BorderRadius.circular(20), 
      ),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding
      (
        padding: EdgeInsets.all(16),
        child: Column
        (
          mainAxisSize: MainAxisSize.min,
          children: 
          [
            Container
            (
              width: 180,
              height: 180,
              decoration: BoxDecoration
              (
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color.fromRGBO(126, 206, 202, 1), width: 2),
                boxShadow: 
                [
                  BoxShadow
                  (
                    color: const Color.fromARGB(255, 218, 217, 217).withOpacity(0.1), 
                    blurRadius: 10, 
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect
              (
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(imagePath, fit: BoxFit.cover,),
              ),
            ),

            SizedBox(height: 20),

            ListTile
            (
              title: Center
              (
                child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk",),),
              ),
              subtitle: Padding
              (
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(subtitle, textAlign: TextAlign.center, style: TextStyle(fontFamily: "Space_Grotesk", color: Colors.white, fontSize: 16,),),
              ),
            ),

            SizedBox(height: 20),

            ButtonBar
            (
              alignment: MainAxisAlignment.center,
              children: 
              [
                ElevatedButton
                (
                  style: ElevatedButton.styleFrom
                  (
                    minimumSize: Size(200, 50),
                    backgroundColor: Color.fromRGBO(126, 206, 202, 1), 
                    shape: RoundedRectangleBorder
                    (
                      borderRadius: BorderRadius.circular(15), 
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    elevation: 5, // Sombra para o botão
                  ),
                  onPressed: onPressed,
                  child: Text("Acessar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white, ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}