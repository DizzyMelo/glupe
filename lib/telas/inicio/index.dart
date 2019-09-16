import 'package:flutter/material.dart';
import 'package:glupe/classes/distribuidor.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/utils/urls.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../distribuidor/index.dart' as telaDistribuidor;

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List<Distribuidor> listaDistribuidores = new List();
  List<Distribuidor> listaDistribuidoresUsados = new List();
  double rating = 4.0;

  buscarDistribuidores() async {
    List<Distribuidor> tempListaDistribuidores = new List();
    List<Distribuidor> tempListaDistribuidoresUsados = new List();


    var res = await http.get(
        Uri.parse("${Urls.urlBase}distribuidores.php?usuario=1"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);

    for (var item in objetos['registros'][0]['distribuidores']) {
      tempListaDistribuidores.add(new Distribuidor(
          id: int.parse(item['id']),
          nome: item['nome'],
          imagem: item['imagem']));
    }

    for (var item in objetos['registros'][0]['distribuidoresUsados']) {
      tempListaDistribuidoresUsados.add(new Distribuidor(
          id: int.parse(item['id']),
          nome: item['nome'],
          imagem: item['imagem']));
    }

    setState(() {
      listaDistribuidores = tempListaDistribuidores;
      listaDistribuidoresUsados = tempListaDistribuidoresUsados;
    });
  }

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
                  Container(
                    height: 80.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                        color: Cores.ceuAzulClaro,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Cores.noiteAzul,
                            offset: new Offset(0.0, 10.0),
                            blurRadius: 10.0,
                          )
                        ],
                        image: DecorationImage(
                            image:
                                NetworkImage('${Urls.imgUsuario}linkedin.jpeg'),
                            fit: BoxFit.cover)),
                  ),
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
              Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 270.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listaDistribuidoresUsados.length,
                  itemBuilder: (BuildContext context, int index) {
                    Distribuidor distribuidor = listaDistribuidoresUsados[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    telaDistribuidor.DistribuidorPage(
                                        distribuidor)));
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 20.0, top: 45.0),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                height: 200.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Cores.noiteAzul,
                                        blurRadius:
                                            10.0, // has the effect of softening the shadow
                                        //spreadRadius: 5.0, // has the effect of extending the shadow
                                        offset: Offset(
                                          0.0, // horizontal, move right 10
                                          10.0, // vertical, move down 10
                                        ),
                                      )
                                    ],
                                    color: Cores.noiteAzul,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 0.0,
                                    ),
                                    Text(
                                      '${distribuidor.nome}',
                                      style: TextStyle(
                                          color: Cores.cristaBranca,
                                          fontSize: 17.0,
                                          fontFamily: 'AvenirBold'),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 180.0,
                                          child: LinearPercentIndicator(
                                            percent: 0.5,
                                            progressColor:
                                                Cores.ceuAzulProfundo,
                                          ),
                                        ),
                                        Container(
                                          width: 50.0,
                                          child: Text(
                                            'GRÁTIS',
                                            style: TextStyle(
                                                color: Cores.cristaBranca,
                                                fontSize: 12.0,
                                                fontFamily: 'AvenirBold'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SmoothStarRating(
                                            allowHalfRating: false,
                                            onRatingChanged: (v) {
                                              rating = v;
                                              setState(() {});
                                            },
                                            starCount: 5,
                                            rating: rating,
                                            size: 15.0,
                                            color: Colors.yellow,
                                            borderColor: Colors.yellow,
                                            spacing: 0.0),
                                        Text(
                                          '1,2 km',
                                          style: TextStyle(
                                              color: Cores.cristaBranca,
                                              fontFamily: 'AvenirRegular'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: -40.0,
                                  left: 85.0,
                                  child: Hero(
                                    tag: 'distribuidorUsado',
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Cores.cristaBranca,
                                              width: 3.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${Urls.imgDistribuidor}${distribuidor.imagem}'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ))
                            ],
                          )),
                    );
                  },
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                'Escolha um distribuidor',
                style: TextStyle(
                    fontFamily: 'AvenirBold',
                    color: Cores.noiteAzul,
                    fontSize: 22.0),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 270.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listaDistribuidores.length,
                  itemBuilder: (BuildContext context, int index) {
                    Distribuidor distribuidor = listaDistribuidores[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    telaDistribuidor.DistribuidorPage(
                                        distribuidor)));
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 20.0, top: 45.0),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                height: 150.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Cores.noiteAzul,
                                        blurRadius:
                                            10.0, // has the effect of softening the shadow
                                        //spreadRadius: 5.0, // has the effect of extending the shadow
                                        offset: Offset(
                                          0.0, // horizontal, move right 10
                                          10.0, // vertical, move down 10
                                        ),
                                      )
                                    ],
                                    color: Cores.noiteAzul,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 0.0,
                                    ),
                                    Text(
                                      '${distribuidor.nome}',
                                      style: TextStyle(
                                          color: Cores.cristaBranca,
                                          fontSize: 17.0,
                                          fontFamily: 'AvenirBold'),
                                    ),
                                    
                                    SizedBox(
                                      height: 0.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SmoothStarRating(
                                            allowHalfRating: false,
                                            onRatingChanged: (v) {
                                              rating = v;
                                              setState(() {});
                                            },
                                            starCount: 5,
                                            rating: rating,
                                            size: 15.0,
                                            color: Colors.yellow,
                                            borderColor: Colors.yellow,
                                            spacing: 0.0),
                                        Text(
                                          '1,2 km',
                                          style: TextStyle(
                                              color: Cores.cristaBranca,
                                              fontFamily: 'AvenirRegular'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: -40.0,
                                  left: 85.0,
                                  child: Hero(
                                    tag: 'distribuidor${distribuidor.id}',
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Cores.cristaBranca,
                                              width: 3.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${Urls.imgDistribuidor}${distribuidor.imagem}'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ))
                            ],
                          )),
                    );
                  },
                ),
              ),
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
    this.buscarDistribuidores();
  }
}
