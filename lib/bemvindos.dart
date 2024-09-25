import 'package:flutter/material.dart';
import 'package:sysale/esqueceuSenha.dart';
import 'package:sysale/home.dart';
import 'package:sysale/users.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> 
{
  late final TextEditingController _loginController;
  late final TextEditingController _senhaController;
  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _senhaFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controla a visibilidade da senha
  bool _isPasswordVisible = false; 

  final List<Usuarios> _usuarios = 
  [
    Usuarios("dani_", "12345678", false),
    Usuarios("sysale", "987654321", true),
  ];

  @override
  void initState() 
  {
    super.initState();
    _loginController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose() 
  {
    _loginFocusNode.dispose();
    _senhaFocusNode.dispose();
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _login() 
  {
    if (_formKey.currentState?.validate() ?? false)
     {
      final String login = _loginController.text;
      final String senha = _senhaController.text;

      final user = _usuarios.firstWhere
      (
        (user) => user.login == login && user.senha == senha,
        orElse: () => Usuarios("", "", false), 
      );

      if (user.login.isNotEmpty) 
      {
        _showDialog
        (
          title: "Seja bem-vindo(a) $login!",
          imagePath: "assets/images/check.png",
          onPressed: () 
          {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(login, _usuarios)),);
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
          content: SizedBox(height: 150, width: 150, child: Image.asset(imagePath),),

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

                _buildForgotPasswordLink(),
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
          if (value == null || value.isEmpty) 
          {
            return "Por favor, insira o $label.";
          }
          if (isPassword && value.length < 8) 
          {
            return "A senha deve ter pelo menos 8 dígitos.";
          }
          if (!isPassword && value.length < 3) 
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

  Widget _buildForgotPasswordLink() 
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [
        Text("Esqueceu a senha?", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "Space_Grotesk")),
        
        SizedBox(width: 5),

        GestureDetector
        (
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyPassword())),
          child: Text("Clique Aqui", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontFamily: "Space_Grotesk", decoration: TextDecoration.underline),),
        ),
      ],
    );
  }
}
