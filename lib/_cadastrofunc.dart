class CadastroFunc
{
  String _nome = "";
  int _cpf = 0;
  String _email = "";

  //GETTERS E SETTERS 

  get cpf => this._cpf;

  set cpf( value) => this._cpf = value;

  String get nome => this._nome;

  set nome(String value) => this._nome = value;

  String get email => this._email;

  set email(String value) => this._email = value;

  //CONSTRUTOR
  CadastroFunc(this._nome, this._cpf, this._email);
  

}