import 'package:flutter/material.dart';
import 'package:glupe/classes/distribuidor.dart';
import 'package:glupe/classes/usuario.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/widgets/cardDistribuidora.dart';
import 'package:glupe/widgets/cardDistribuidoraUsada.dart';
import 'package:glupe/widgets/imagemUsuario.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List<Distribuidor> listaDistribuidores = new List();
  List<Distribuidor> listaDistribuidoresUsados = new List();
  

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Cores.cristaBranca,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ImagemUsuario(Usuario.superUsuario.imagem),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: new Text("50%"),
                    progressColor: Colors.green,
                  )
                ],
              ),
              SizedBox(height: 50.0),
              Text(
                'Distribuidoras que você já usou',
                style: TextStyle(
                    fontFamily: 'AvenirBold',
                    color: Cores.noiteAzul,
                    fontSize: 22.0),
              ),
              CardDistribuidoraUsada(),
              SizedBox(height: 50.0),
              Text(
                'Escolha um distribuidor',
                style: TextStyle(
                    fontFamily: 'AvenirBold',
                    color: Cores.noiteAzul,
                    fontSize: 22.0),
              ),
              CardDistribuidora()
            ],
          ),
        ),
            )
        )
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
