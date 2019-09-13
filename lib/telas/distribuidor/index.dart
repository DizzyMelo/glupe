import 'package:flutter/material.dart';

class Distribuidor extends StatefulWidget {
  @override
  _DistribuidorState createState() => _DistribuidorState();
}

class _DistribuidorState extends State<Distribuidor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[  
            Text('Distribuidor')
          ],
        ),
      ),
    ));
  }
}
