// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sysale/_cadastrar.dart';
import 'package:sysale/bemvindos.dart';
import 'package:sysale/consultar.dart';
import 'package:sysale/perfil.dart';
import 'package:sysale/users.dart';

class MyHomePage extends StatefulWidget {
  final String nome;
  final List<Usuarios> listaUser;

  MyHomePage(this.nome, this.listaUser, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
        actions: 
        [
          IconButton
          (
            icon: Icon(Icons.person),
            onPressed: () 
            {
              final usuarioLogado = widget.listaUser.firstWhere
              (
                (user) => user.login == widget.nome,
                orElse: () => Usuarios("", "", false),
              );

              if (usuarioLogado.login.isEmpty) 
              {
                print("No matching user found.");
                return;
              }

              Navigator.push
              (
                context,
                MaterialPageRoute
                (
                  builder: (context) => MyPerfil(userName: widget.nome, listaUser: widget.listaUser, usuarioLogado: usuarioLogado,),
                ),
              );
            },
          ),
        ],
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
                fit: BoxFit.cover, // preenche a tela inteira
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
                    Text("Bem vindo(a) ${widget.nome} !", style: TextStyle(color: Color.fromARGB(255, 160, 222, 214), fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Space_Grotesk",),),
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

                SizedBox(height: 30),
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
          color: Color.fromARGB(255, 250, 255, 253),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: Padding
          (
            padding: EdgeInsets.all(20),
            child: Column
            (
              mainAxisSize: MainAxisSize.min,
              children: 
              [
                Container
                (
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all
                    (
                      color: Color.fromARGB(255, 196, 255, 247),
                    ),
                  ),
                ),

                SizedBox(height: 70),

                ListTile
                (
                  title: Center
                  (
                    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 160, 222, 214), fontFamily: "Space_Grotesk",),),
                  ),
                  subtitle: Text(subtitle, textAlign: TextAlign.center, style: TextStyle(fontFamily: "Space_Grotesk"),),
                ),

                SizedBox(height: 50),

                ButtonBar
                (
                  alignment: MainAxisAlignment.center,
                  children: 
                  [
                    TextButton
                    (
                      onPressed: onPressed,
                      child: Text("Acessar",style: TextStyle(fontSize: 15, color: Colors.cyan),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
