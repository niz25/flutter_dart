import 'package:flutter/material.dart';

class MyAtualizar extends StatefulWidget {
  const MyAtualizar({super.key});

  @override
  State<MyAtualizar> createState() => _MyAtualizarState();
}

class _MyAtualizarState extends State<MyAtualizar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromRGBO(126, 206, 202, 1),
        title: Text('Atualizar', style: TextStyle(color: Colors.white),),
        toolbarHeight: 71,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

    );
  }
}