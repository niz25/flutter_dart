class CadastroFunc
{
  String _nome = "";
  String _cpf = "";
  String _email = "";

  //GETTERS E SETTERS 

  // CPF
  String get cpf => this._cpf;
  set cpf(String value) => this._cpf = value;

  // NOME
  String get nome => this._nome;
  set nome(String value) => this._nome = value;

  // EMAIL
  String get email => this._email;
  set email(String value) => this._email = value;

  // -------------------------------------------------

  CadastroFunc();

  CadastroFunc.fromJson(Map<String, dynamic> json)
  :
    _cpf = json["cpf"],
    _nome = json["nome"],
    _email = json["email"];


  //CONSTRUTOR
  //CadastroFunc(this._nome, this._cpf, this._email);
  

}