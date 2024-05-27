// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';
import '_paginacadastro.dart';

class MyCadastro extends StatefulWidget {
  const MyCadastro({Key? key}) : super(key: key);

  @override
  State<MyCadastro> createState() => _MyCadastroState();
}

class _MyCadastroState extends State<MyCadastro> {
  bool? funcionarioSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text("Cadastrar",style: TextStyle(color: Colors.white),),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView
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
                  onTap: () {
                    setState(() {
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
                        //se estiver selecionado a borda fica verde, senão azul
                          color: funcionarioSelected == true
                              ? const Color.fromARGB(255, 185, 222, 160) : Color.fromARGB(255, 69, 181, 196)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      boxShadow: 
                      [
                        BoxShadow
                        (
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3)
                        )
                      ],
                    ),
                    child: ClipRRect
                    (
                      borderRadius: BorderRadius.circular(90),
                      child: Image.asset('assets/images/workers.png', fit: BoxFit.cover,),
                    ),
                  ),
                ),
                ),
                

                MouseRegion
                (
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector
                (
                  onTap: () {
                    setState(() {
                      funcionarioSelected = false;
                    });
                  },
                  child: Container
                  (
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all
                      (
                          color: funcionarioSelected == false
                              ? const Color.fromARGB(255, 185, 222, 160)  : Color.fromARGB(255, 69, 181, 196)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      boxShadow: 
                      [
                        BoxShadow
                        (
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3)
                        )
                      ],
                    ),
                    child: ClipRRect
                    (
                      borderRadius: BorderRadius.circular(90),
                      child: Image.asset('assets/images/items.png', fit: BoxFit.cover,),
                    ),
                  ),
                ),
                ),
                
              ],
            ),

            SizedBox(height: 10,),

            Row
            (
              //mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                SizedBox(width: 18,),
                Text("Funcionários", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 69, 181, 196)),),
                SizedBox(width: 192,),
                Text("Produtos", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 69, 181, 196)),),
              ],
            ),
            SizedBox(height: 20,),
            Divider(),
            SizedBox(height: 20,),

            // Exibe os formulários somente se algum gesture for selecionado
            if (funcionarioSelected != null)
              if (funcionarioSelected!)
                FuncionarioFormWidget()
              else
                ProdutoFormWidget(),
          ],
        ),
      ),
    );
  }
}
