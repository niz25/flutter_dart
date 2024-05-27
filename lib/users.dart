class Usuarios
{
  String _login = "";
  int _senha = 0;
  bool _func = false;

  //GETTERS E SETTERS
  get senha => this._senha;

  set senha( value) => this._senha = value;

  String get login => this._login;

  set login(String value) => this.login = value;

  get func => this._func;

  set func( value) => this._func = value;

  //CONSTRUTOR
  Usuarios(this._login, this._senha, this._func);
}