import 'package:flutter/material.dart';
import 'package:glupe/classes/usuario.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/navegacao/index.dart';
import 'package:glupe/telas/inicio/index.dart';
import 'package:glupe/utils/urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();

  login() async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.post(
        Uri.parse(
            "${Urls.urlBase}login.php"),
        headers: {"Accept": "application/json"},
        body: {
          "email": emailController.text,
          "senha": senhaController.text 
        });

    var obj = json.decode(res.body);

    print(obj);

    try{
      Usuario usuario = new Usuario(
        id: int.parse(obj["0"]),
        nome: obj['nome'],
        imagem: obj['imagem'],
        email: obj['email'],
        celular: obj['celular'],
        status: int.parse(obj['sts'])
      );

      Usuario.superUsuario = usuario;
      
      prefs.setInt("id", int.parse(obj["0"]));
      prefs.setString("nome", obj['nome']);
      prefs.setString("imagem", obj['imagem']);
      prefs.setString("email", obj['email']);
      prefs.setString("celular", obj['celular']);

      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Inicio()));

                                

    }catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Cores.cristaBranca,
      resizeToAvoidBottomPadding: false,
      body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width: double.infinity,
                  height: h / 1.9,
                  decoration: BoxDecoration(
                    color: Cores.ceuAzulProfundo,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Cores.ceuAzulClaro,
                        blurRadius: 20.0, // has the effect of softening the shadow
                        spreadRadius: 5.0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[


                       Container(
                            height: 50.0,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              onSubmitted: (txt){
                                this.login();
                              },
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Cores.cristaBranca,
                                      width: 3.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Cores.cristaBranca,
                                      width: 3.2),
                                ),
                                hintText: 'E-mail',
                                hintStyle: TextStyle(color: Colors.white)
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            child: TextField(
                              controller: senhaController,
                              obscureText: true,
                              onSubmitted: (txt){
                                this.login();
                              },
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Cores.cristaBranca,
                                      width: 3.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Cores.cristaBranca,
                                      width: 3.2),
                                ),
                                hintText: 'Senha',
                                hintStyle: TextStyle(color: Colors.white)
                              ),
                            ),
                          ),

                          FlatButton(
                            child: Text('Crie sua conta', style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'MonMedium' ),),
                            onPressed: (){
                              Navegacao.navegarParaCadstro(context);
                            },
                          ),
                          Text('Esqueceu sua senha?', style: TextStyle(color: Colors.white),),


                      GestureDetector(
                        onTap: (){
                          this.login();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Cores.melancia,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          height: 50.0,
                          width: double.infinity,
                          child: Center(
                            child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'MonMedium'),),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
      )),
    );
  }
}