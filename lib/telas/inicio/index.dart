import 'package:flutter/material.dart';
import 'package:glupe/cores/index.dart';

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


              SizedBox(height: 40.0),

              Container(
                padding: EdgeInsets.only(top: 10.0),
                height: 170.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                        height: 140.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                              BoxShadow(
                                color: Cores.ceuAzulClaro,
                                blurRadius: 10.0, // has the effect of softening the shadow
                                //spreadRadius: 5.0, // has the effect of extending the shadow
                                offset: Offset(
                                  0.0, // horizontal, move right 10
                                  10.0, // vertical, move down 10
                                ),
                              )
                            ],
                          color: Cores.ceuAzulProfundo,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                      ),
                      Positioned(
                        top: -10.0,
                        right:70.0,
                        child: CircleAvatar(
                          minRadius: 30.0,
                        ),
                      )
                        ],
                      )
                    );
                  },
                ),
              )
            ],
          ),
          )
        ));
  }
}
