import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sysale/home.dart';

class MyFirstPage extends StatefulWidget {
  
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> 
{

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _senhaFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() 
  {
    _loginFocusNode.dispose();
    _senhaFocusNode.dispose();
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _login() async 
  {
    if(_formKey.currentState?.validate() ?? false) 
    {
      final String login = _loginController.text;
      final String senha = _senhaController.text;

      final response = await _autenticarLogin(login, senha);

      if(response != null && response['status'] == 'success') 
      {
        _showDialog
        (
          title: "Seja bem-vindo(a) $login!",
          imagePath: "assets/images/check.png",
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(userName: login)),);
          },
        );
      } 
      else 
      {
        _showDialog
        (
          title: "Login ou senha incorretos!",
          imagePath: "assets/images/error.png",
        );
      }
    }
  }

  Future<Map<String, dynamic>?> _autenticarLogin(String login, String senha) async 
  {
    final url = Uri.parse('http://localhost:8080/apiLogin/validar');
    final headers = {'Content-Type': 'application/json'};
    
    final body = json.encode({
      'nome': login,
      'senha': senha,
    });

    try 
    {
      final response = await http.post(url, headers: headers, body: body);

      if(response.statusCode == 200) 
      {
        return json.decode(response.body);
      } 
      else 
      {
        return null;
      }
    } 
    catch(e) 
    {
      print("Erro ao fazer a requisição: $e");
      return null;
    }
  }

  void _showDialog({required String title, required String imagePath, VoidCallback? onPressed}) 
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
            children: 
            [
              Icon(Icons.check),
              SizedBox(width: 5),
              Text(title, style: TextStyle(fontFamily: "Space_Grotesk")),
            ],
          ),
          content: SizedBox(height: 150, width: 150, child: Image.asset(imagePath)),
          actions: 
          [
            TextButton
            (
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: Text("OK", style: TextStyle(color: Colors.cyan)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: SingleChildScrollView
        (
          child: Form
          (
            key: _formKey,
            child: Column
            (
              children:
               [
                SizedBox(height: 120),

                Text("SYSALE",style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, fontFamily: "TAN Nimbus", color: Color.fromARGB(255, 160, 205, 207)),),
                Text("Sistema de Vendas", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "TAN Nimbus", color: Color.fromARGB(255, 160, 205, 207)),),

                SizedBox(height: 40),

                SizedBox(width: 550, child: Image.asset("assets/images/login.png")),

                SizedBox(height: 15),

                _buildTextField(_loginController, _loginFocusNode, "Login", Icons.person),

                SizedBox(height: 20),

                _buildTextField(_senhaController, _senhaFocusNode, "Senha", Icons.lock, isPassword: true),

                SizedBox(height: 20),

                _buildLoginButton(),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, FocusNode focusNode, String label, IconData icon, {bool isPassword = false}) 
  {
    return Padding
    (
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField
      (
        focusNode: focusNode,
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible, 
        decoration: InputDecoration
        (
          prefixIcon: Icon(icon),
          labelText: label,
          labelStyle: TextStyle(fontFamily: "Space_Grotesk"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          suffixIcon: isPassword ? IconButton
          (
            icon: Icon
            (
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () 
            {
              setState(() 
              {
                _isPasswordVisible = !_isPasswordVisible; 
              });
            },
          ) : null,
        ),

        validator: (value) 
        {
          if(value == null || value.isEmpty) 
          {
            return "Por favor, insira o $label.";
          }
          if(isPassword && value.length < 8) 
          {
            return "A senha deve ter pelo menos 8 dígitos.";
          }
          if(!isPassword && value.length < 3) 
          {
            return "O login deve ter pelo menos 3 caracteres.";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() 
  {
    return ElevatedButton
    (
      onPressed: _login,
      style: ElevatedButton.styleFrom
      (
        padding: EdgeInsets.all(20.0),
        minimumSize: Size(200, 50),
        backgroundColor: Color.fromARGB(255, 160, 205, 207),
      ),
      child: Text("Entrar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Space_Grotesk"),),
    );
  }
}
