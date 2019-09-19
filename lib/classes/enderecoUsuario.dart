class EnderecoUsuario {
  int id;
  double latitude, longitude;
  String rua, numero, complemento, bairro, cidade, cep;

  EnderecoUsuario({this.id, this.bairro, this.cep, this.cidade, this.complemento, this.latitude, this.longitude, this.numero, this.rua});
}