class Usuarios
{
  String _login = "";
  String _senha = "";
  bool _tipo = false;

  //GETTERS E SETTERS

  // SENHA
  String get senha => this._senha;
  set senha(String value) => this.senha = value;

  // LOGIN/NOME
  String get login => this._login;
  set login(String value) => this.login = value;

  // TIPO
  get tipo => this._tipo;
  set tipo( value) => this._tipo = value;

  // -------------------------------------------------

  Usuarios();

  Usuarios.fromJson(Map<String, dynamic> json)
  :
    _senha = json["senha"],
    _login = json["nome"],
    _tipo = json["tipo"];

  //CONSTRUTOR
  //Usuarios(this._login, this._senha, this._tipo);
}