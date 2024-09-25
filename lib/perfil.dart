// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 
import 'package:sysale/users.dart'; 

class MyPerfil extends StatefulWidget 
{
  final String userName;
  final List<Usuarios> listaUser;
  final Usuarios usuarioLogado;

  MyPerfil({required this.userName, required this.listaUser, required this.usuarioLogado, Key? key}) : super(key: key);

  @override
  _MyPerfilState createState() => _MyPerfilState();
}

class _MyPerfilState extends State<MyPerfil> 
{
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _loginController = TextEditingController();
  //variável que controla a edição
  bool _isEditing = false;

  @override
  void initState() 
  {
    super.initState();
    //preenche o campo com o usuário pré-definido
    _loginController.text = widget.usuarioLogado.login;
  }

  Future<void> _pickImage() async 
  {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) 
    {
      setState(() 
      {
        _image = File(pickedFile.path);
      });
    }
  }

  void _salvarInformacoes() 
  {
    final updatedUser = Usuarios(_loginController.text, '', widget.usuarioLogado.login == "dani_" ? true : false,);

    print("Updated User: ${updatedUser.login}, Func: ${updatedUser.func}");
  }

  @override
  Widget build(BuildContext context) 
  {
    bool isEmployee = widget.usuarioLogado.login == "dani_";
    bool isManager = widget.usuarioLogado.login == "sysale";

    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Perfil", style: TextStyle(fontFamily: "Space_Grotesk"),),
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1), 
        foregroundColor: Colors.white,
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
                image: AssetImage("assets/images/fundo_perfil.png"),
                fit: BoxFit.cover, 
              ),
            ),
          ),

          SingleChildScrollView
          (
            padding: EdgeInsets.all(20),
            child: Column
            (
              children: 
              [
                 Align
                 (
                  alignment: Alignment.center,
                  child: Text("Foto de perfil", style: TextStyle(fontSize: 20, fontFamily: "Space_Grotesk",)),
                ),

                SizedBox(height: 20),

                GestureDetector
                (
                  onTap: _pickImage,
                  child: CircleAvatar
                  (
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? Icon(Icons.camera_alt, size: 50) : null,
                  ),
                ),

                SizedBox(height: 50),
               
                GestureDetector
                (
                  onTap: () 
                  {
                    setState(() 
                    {
                      //muda o estado
                      _isEditing = !_isEditing; 
                    });
                  },
                  child: MouseRegion
                  (
                    cursor: SystemMouseCursors.click,
                    child: AbsorbPointer
                    (
                      absorbing: !_isEditing, 
                      child: TextField
                      (
                        controller: _loginController,
                        enabled: _isEditing, 
                        decoration: InputDecoration
                        (
                          labelText: "Nome de Usuário",
                          labelStyle: TextStyle(fontFamily: "Space_Grotesk"),
                          border: OutlineInputBorder
                          (
                            borderRadius: BorderRadius.circular(30),
                          ),

                          focusedBorder: OutlineInputBorder
                          (
                            borderSide: BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: Icon(_isEditing ? Icons.check : Icons.edit), 
                        ),
                      ),
                    ),
                  )
                ),

                SizedBox(height: 20),

                TextField
                (
                  enabled: false, 
                  decoration: InputDecoration
                  (
                    labelText: isEmployee ? "Funcionário" : isManager ? "Gerente" : "Desconhecido",
                    labelStyle: TextStyle(fontFamily: "Space_Grotesk"),
                    border: OutlineInputBorder
                    (
                      borderRadius: BorderRadius.circular(30),
                    ),

                    focusedBorder: OutlineInputBorder
                    (
                      borderSide: BorderSide(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton
                (
                  onPressed: _salvarInformacoes,
                  child: Text("Salvar", style: TextStyle(color: Colors.white, fontFamily: "Space_Grotesk", fontWeight: FontWeight.bold)), 
                  style: ElevatedButton.styleFrom
                  (
                    padding: EdgeInsets.all(20.0),
                    minimumSize: Size(200, 50),
                    backgroundColor:Color.fromARGB(255, 160, 205, 207),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
