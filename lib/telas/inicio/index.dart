import 'package:flutter/material.dart';
import 'package:glupe/cores/index.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Cores.cristaBranca,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Olá, Daniel',
                style: TextStyle(
                    color: Cores.noiteAzul,
                    fontSize: 24.0,
                    fontFamily: 'MonMedium'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'GRÁTIS',
                    style: TextStyle(
                        color: Cores.noiteAzul,
                        fontSize: 24.0,
                        fontFamily: 'MonMedium'),
                  ),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: new Text("100%"),
                    progressColor: Colors.green,
                  )
                ],
              ),
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 170.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              height: 140.0,
                              width: 160.0,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Cores.ceuAzulClaro,
                                      blurRadius:
                                          10.0, // has the effect of softening the shadow
                                      //spreadRadius: 5.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        0.0, // horizontal, move right 10
                                        10.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                  color: Cores.ceuAzulProfundo,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Cores.cristaBranca, width: 3.0),
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              )
            ],
          ),
        )));
  }
}
