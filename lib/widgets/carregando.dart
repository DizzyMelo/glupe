import 'package:flutter/material.dart';

class CarregandoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: 30.0,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ),
            );
  }
}