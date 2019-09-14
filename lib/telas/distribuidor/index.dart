import 'package:flutter/material.dart';
import 'package:glupe/classes/distribuidor.dart';
import 'package:glupe/classes/produto.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/utils/urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DistribuidorPage extends StatefulWidget {
  Distribuidor distribuidor;

  DistribuidorPage(this.distribuidor);
  @override
  _DistribuidorPageState createState() => _DistribuidorPageState();
}

class _DistribuidorPageState extends State<DistribuidorPage> {
  List<Produto> listaProdutos = new List();

  buscarProdutos() async {
    List<Produto> tempListaProdutos = new List();
    var res = await http.get(
        Uri.parse(
            "${Urls.urlBase}produtos.php?distribuidor=${widget.distribuidor.id}"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);

    for (var item in objetos['produtos']) {
      tempListaProdutos.add(new Produto(
          id: int.parse(item['id']),
          volume: int.parse(item['volume']),
          valor: double.parse(item['valor']),
          nome: item['nome']));
    }

    setState(() {
      listaProdutos = tempListaProdutos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(color: Cores.noiteAzul),
                ),
                Column(
                  children: <Widget>[
                    Hero(
                      tag: 'distribuidor',
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Cores.cristaBranca, width: 3.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${Urls.imgDistribuidor}${widget.distribuidor.imagem}'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '${widget.distribuidor.nome}',
                      style: TextStyle(
                          color: Cores.cristaBranca,
                          fontSize: 18.0,
                          fontFamily: 'AvenirBold'),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  height: 270.0,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listaProdutos.length,
                    itemBuilder: (BuildContext context, int index) {
                      Produto produto = listaProdutos[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.0, top: 45.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Cores.noiteAzul,
                                    blurRadius: 10.0,
                                    offset: Offset(
                                      0.0, // horizontal, move right 10
                                      10.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                color: Cores.noiteAzul,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 0.0,
                                ),
                                Image.asset('assets/img/water.png'),
                                Text(
                                  '${produto.nome}',
                                  style: TextStyle(
                                      color: Cores.cristaBranca,
                                      fontSize: 17.0,
                                      fontFamily: 'AvenirBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.buscarProdutos();
  }
}
