import 'package:flutter/material.dart';
import 'package:glupe/classes/distribuidor.dart';
import 'package:glupe/constantes/index.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/telas/distribuidor/index.dart';
import 'package:glupe/utils/urls.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CardDistribuidora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 270.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Constantes.listaDistribuidores.length,
                  itemBuilder: (BuildContext context, int index) {
                    Distribuidor distribuidor = Constantes.listaDistribuidores[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DistribuidorPage(
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
                                            starCount: 5,
                                            rating: distribuidor.rating,
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
              );
  }
}