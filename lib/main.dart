import 'package:equinox/equinox.dart';
import 'package:equinox/equinox.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:glupe/telas/cadastro/endereco.dart';
import 'package:glupe/telas/cadastro/index.dart';
import 'package:glupe/telas/cadastro/teste.dart';
import 'package:glupe/telas/inicio/index.dart';
import 'package:glupe/telas/login/index.dart';
import 'package:glupe/telas/splash/index.dart';
import 'cores/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EquinoxApp(
      debugShowCheckedModeBanner: false,
      title: 'Glupe',
      theme: EqThemes.defaultLightTheme,
      home: Cadastro(),
    );
  }
}
