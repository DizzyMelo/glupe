/*

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}


SELECT DISTINCT pedido.usuario, distribuidor.nome, distribuidor.imagem, (SELECT COUNT(id) FROM pedido WHERE pedido.usuario = 1) AS contador FROM pedido JOIN distribuidor ON (pedido.distribuidor = distribuidor.id) WHERE pedido.usuario = 1


class _TabsState extends State<Tabs> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
      selectedIndex: currentIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        currentIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.red,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: Colors.purpleAccent),
        BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
            activeColor: Colors.pink),
        BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue),
      ],
    ));
  }
}
*/