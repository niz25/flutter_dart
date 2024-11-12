class Usuarios
{
  String _login = "";
  String _senha = "";
  bool _tipo = false;

  //GETTERS E SETTERS
  String get senha => this._senha;

  set senha(String value) => this.senha = value;

  String get login => this._login;

  set login(String value) => this.login = value;

  get tipo => this._tipo;

  set tipo( value) => this._tipo = value;

  //CONSTRUTOR
  Usuarios(this._login, this._senha, this._tipo);
}