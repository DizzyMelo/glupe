import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:glupe/cores/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EnderecoPage extends StatefulWidget {
  @override
  _EnderecoPageState createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  String cep = "";

  buscarEndereco(String cep) async {


    var res = await http.get(
        Uri.parse("https://viacep.com.br/ws/$cep/json/"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);

    print(objetos);

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BeautyTextfield(  
                  backgroundColor: Cores.cristaBranca,
                  accentColor: Cores.noiteAzul,
                  textColor: Cores.cinza,
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  prefixIcon: Icon(Icons.location_on),
                  //suffixIcon: Icon(Icons.remove_red_eye),
                  placeholder: "CEP",
                  onTap: () {
                      print('Click');
                  },
                  onChanged: (text) {
                      setState(() {
                       cep = text; 
                      });
                  },
                  onSubmitted: (data) {
                      print(data.length);
                  },
              ),
              
              GestureDetector(
                        onTap: (){
                          buscarEndereco(cep);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Cores.melancia,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          height: 50.0,
                          width: width / 3,
                          child: Center(
                            child: Text('BUSCAR', style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'AvenirBold'),),
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}