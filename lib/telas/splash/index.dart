import 'package:flutter/material.dart';
import 'package:glupe/classes/distribuidor.dart';
import 'package:glupe/classes/pedido.dart';
import 'package:glupe/classes/usuario.dart';
import 'package:glupe/constantes/index.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/navegacao/index.dart';
import 'package:glupe/utils/urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  varificarSeEstaLogado() async {
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getInt("id") == null || prefs.getInt("id") == 0){
      Navegacao.navegarParaLogin(context);
    }else{
      //Navegacao.navegarParaLogin(context);
      
      int id = prefs.getInt("id");
      String nome = prefs.getString("nome");
      String imagem = prefs.getString("imagem");
      String email = prefs.getString("email");
      String celular = prefs.getString("celular");

      Usuario usuario = new Usuario(
        id: id,
        nome: nome,
        imagem: imagem,
        email: email,
        celular: celular
      );

      Usuario.superUsuario = usuario;
      
      this.verificarPedidoAberto();
      this.buscarDistribuidores();
    }
  }


  buscarDistribuidores() async {
    List<Distribuidor> tempListaDistribuidores = new List();
    List<Distribuidor> tempListaDistribuidoresUsados = new List();


    var res = await http.get(
        //Uri.parse("${Urls.urlBase}distribuidores.php?usuario=${Usuario.superUsuario.id}"),
        Uri.parse("${Urls.urlBase}distribuidores.php?usuario=${Usuario.superUsuario.id}"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);

    for (var item in objetos['registros'][0]['distribuidores']) {
      tempListaDistribuidores.add(new Distribuidor(
          id: int.parse(item['id']),
          nome: item['nome'],
          imagem: item['imagem'],
          gratis: int.parse(item['gratis']),
          rating: double.parse(item['rating'])
          ));
    }

    for (var item in objetos['registros'][0]['distribuidoresUsados']) {
      tempListaDistribuidoresUsados.add(new Distribuidor(
          id: int.parse(item['id']),
          nome: item['nome'],
          imagem: item['imagem'],
          contador: int.parse(item['contador']),
          gratis: int.parse(item['gratis']),
          rating: double.parse(item['rating'])
          ));
    }

    setState(() {
      Constantes.listaDistribuidores = tempListaDistribuidores;
      Constantes.listaDistribuidoresUsados = tempListaDistribuidoresUsados;
      Navegacao.navegarParaInicio(context);
    });
  }

  verificarPedidoAberto() async {

    var res = await http.get(
        Uri.parse("${Urls.urlBase}verificarPedidoAberto.php?usuario=${Usuario.superUsuario.id}"),
        headers: {"Accept": "application/json"});

    var obj = json.decode(res.body);
    print(obj);


    setState(() {
      if(obj != false){
        Constantes.pedidoAberto = new Pedido(int.parse(obj['id']), double.parse(obj['valor']));
      }
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Glupe',
              style: TextStyle(
                  color: Cores.ceuAzulProfundo,
                  fontSize: 38.0,
                  fontFamily: 'AvenirBold'),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              height: 30.0,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ),
            ),
          ],
        )
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.varificarSeEstaLogado();
  }
}
