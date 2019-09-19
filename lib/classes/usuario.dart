import 'enderecoUsuario.dart';

class Usuario {
  int id, status;
  String nome, email, senha, imagem, celular;
  EnderecoUsuario enderecoUsuario;

  Usuario({this.id, this.celular, this.email, this.imagem, this.nome, this.senha, this.status, this.enderecoUsuario});

  static Usuario superUsuario;
}