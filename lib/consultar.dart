import 'package:flutter/material.dart';
import 'paginaconsulta.dart';

class MyConsulta extends StatefulWidget {
  const MyConsulta({Key? key}) : super(key: key);

  @override
  State<MyConsulta> createState() => _MyConsultaState();
}

class _MyConsultaState extends State<MyConsulta> 
{
  bool? funcionarioSelected;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text("Consultar/Atualizar", style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk"),),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
                image: AssetImage("assets/images/fundo_funcao.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView
          (
            padding: EdgeInsets.all(30),
            child: Column
            (
              children: 
              [
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: 
                  [
                    MouseRegion
                    (
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector
                      (
                        onTap: () 
                        {
                          setState(() 
                          {
                            funcionarioSelected = true;
                          });
                        },
                        child: Container
                        (
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration
                          (
                            border: Border.all
                            (
                              color: funcionarioSelected == true
                                  ? const Color.fromARGB(255, 185, 222, 160)
                                  : Color.fromARGB(255, 69, 181, 196),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                            boxShadow: 
                            [
                              BoxShadow
                              (
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect
                          (
                            borderRadius: BorderRadius.circular(90),
                            child: Image.asset("assets/images/workers.png", fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ),

                    MouseRegion
                    (
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector
                      (
                        onTap: () 
                        {
                          setState(() 
                          {
                            funcionarioSelected = false;
                          });
                        },
                        child: Container
                        (
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration
                          (
                            border: Border.all
                            (
                              color: funcionarioSelected == false
                                  ? const Color.fromARGB(255, 185, 222, 160)
                                  : Color.fromARGB(255, 69, 181, 196),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                            boxShadow: 
                            [
                              BoxShadow
                              (
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect
                          (
                            borderRadius: BorderRadius.circular(90),
                            child: Image.asset("assets/images/items.png",fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row
                (
                  children:
                  [
                    SizedBox(width: 18),

                    Text("Funcionários", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 69, 181, 196), fontFamily: "Space_Grotesk",),),

                    SizedBox(width: 192),

                    Text("Produtos", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 69, 181, 196), fontFamily: "Space_Grotesk",),),
                  ],
                ),

                SizedBox(height: 20),

                Divider(),

                SizedBox(height: 20),

                // exibe os formulários somente se algum gesture for selecionado
                if (funcionarioSelected != null)
                  funcionarioSelected! ? FuncionarioFormWidget() : ProdutoFormWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
