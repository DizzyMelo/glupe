import 'package:flutter/material.dart';
import 'package:glupe/widgets/imagemUsuario.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ImagemUsuario("linkedin.jpeg")],
          ),
        )),
      ),
    );
  }
}
