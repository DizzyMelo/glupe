import 'package:flutter/material.dart';
import 'package:glupe/classes/distribuidor.dart';
import 'package:glupe/classes/produto.dart';
import 'package:glupe/classes/usuario.dart';
import 'package:glupe/constantes/index.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/utils/urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


class DistribuidorPage extends StatefulWidget {
  Distribuidor distribuidor;

  DistribuidorPage(this.distribuidor);
  @override
  _DistribuidorPageState createState() => _DistribuidorPageState();
}

class _DistribuidorPageState extends State<DistribuidorPage> {
  List<Produto> listaProdutos = new List();
  double rating = 4.0;

  iniciarPedido(int distribuidor) async {
    var res = await http.post(
        Uri.parse("${Urls.urlBase}iniciarPedido.php"),
        body: {
          "distribuidor": distribuidor,
          "usuario": Usuario.superUsuario.id
        },
        headers: {"Accept": "application/json"});

    var obj = json.decode(res.body);
    print(obj);
    setState(() {

    });
  }

  adicionarProduto(int distribuidor, int pedido, Produto produto, int qtd, ) async {

    //if(Constantes.pedidoAberto == null){
      //iniciarPedido(distribuidor);
    //}

    double valor = produto.valor * qtd;

    var res = await http.post(
        Uri.parse("${Urls.urlBase}adicionarProduto.php"),
        body: {
          "pedido": pedido.toString(),
          "produto": produto.id.toString(),
          "qtd": qtd.toString(),
          "valor" : valor.toString()
        },
        headers: {"Accept": "application/json"});

    var obj = json.decode(res.body);
    
    print("ADICIONANDO O PRODUTO");
    print(obj);

    setState(() {

    });
  }

  _buildCard({Config config, Color backgroundColor = Colors.transparent}) {
    return Container(
      height: 300.0,
      width: 250.0,
      child: Card(
        elevation: 12.0,
        margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: WaveWidget(
          config: config,
          backgroundColor: backgroundColor,
          size: Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
    );
  }



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
    double w = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Cores.cristaBranca,
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),

                      Hero(
                        tag: 'distribuidor${widget.distribuidor.id}',
                        child: Container(
                          width: 90.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Cores.ceuAzulProfundo, width: 5.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${Urls.imgDistribuidor}${widget.distribuidor.imagem}'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${widget.distribuidor.nome}',
                              style: TextStyle(
                                  color: Cores.noiteAzul,
                                  fontSize: 18.0,
                                  fontFamily: 'AvenirBold'),
                            ),
                            SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: rating,
                                size: 20.0,
                                color: Colors.yellow,
                                borderColor: Colors.yellow,
                                spacing: 0.0),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
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
                            onTap: () {
                              
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 45.0),
                              child: _buildCard(
                                        config: CustomConfig(
                                          colors: [
                                            Colors.blue[400],
                                            Colors.blue[300],
                                            Colors.blue[200],
                                            Colors.blue[100]
                                          ],
                                          durations: [35000, 19440, 10800, 6000],
                                          heightPercentages: [0.20, 0.23, 0.25, 0.30],
                                          //blur: _blur,
                                        ),
                                      ),
                              /*
                              Container(
                                height: 100.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                    
                                    color: Cores.noiteAzul,
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            this.adicionarProduto(widget.distribuidor.id, 1, produto, 1);
                                          },
                                          child: Container(
                                            height: 45.0,
                                            width: 45.0,
                                            child: Icon(Icons.add, color: Cores.cristaBranca, size: 30.0,),
                                            decoration: BoxDecoration(
                                              color: Cores.melancia,
                                              borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                    
                                    Text(
                                      '${produto.nome}',
                                      style: TextStyle(
                                          color: Cores.cristaBranca,
                                          fontSize: 17.0,
                                          fontFamily: 'AvenirBold'),
                                    ),
                                    Container(
                                      height: 60.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Cores.ceuAzulProfundo,
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            '${produto.volume} litros',
                                            style: TextStyle(
                                                color: Cores.noiteAzul,
                                                fontSize: 21.0,
                                                fontFamily: 'AvenirRegular'),
                                          ),
                                          Text(
                                            '\$${produto.valor}',
                                            style: TextStyle(
                                                color: Cores.noiteAzul,
                                                fontSize: 21.0,
                                                fontFamily: 'AvenirRegular'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              */
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
