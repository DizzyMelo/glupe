import 'package:flutter/material.dart';
import 'package:glupe/telas/inicio/index.dart';
import 'package:glupe/telas/login/index.dart';
import 'package:glupe/telas/perfil/index.dart';

class Navegacao{

  static navegarParaInicio(BuildContext context){
    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Inicio()));
  }

  static navegarParaPerfil(BuildContext context){
    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Perfil()));
  }

  static navegarParaLogin(BuildContext context){
    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Login()));
  }
}