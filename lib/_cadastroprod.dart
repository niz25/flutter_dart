class CadastroProd
{
  int _cod = 0;
  String _nome = "";
  double _preco = 0;
  int _qtde = 0;

  //GETTERS E SETTERS 

  // CÓDIGO
  get cod => this._cod;
  set cod( value) => this._cod = value;

  // NOME
  String get nome => this._nome;
  set nome(String value) => this._nome = value;

  // PREÇO
  get preco => this._preco;
  set preco( value) => this._preco = value;

  // QUANTIDADE
  get qtde => this._qtde;
  set qtde( value) => this._qtde = value;

  // -------------------------------------------------

  CadastroProd();

  CadastroProd.fromJson(Map<String, dynamic> json)
  :
    _cod = json["codigo"],
    _nome = json["nome"],
    _preco = json["preco"],
    _qtde = json["quantidade"];

  //CONSTRUTOR
  //CadastroProd(this._cod, this._nome, this._preco, this._qtde);

}