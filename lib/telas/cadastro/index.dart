import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:equinox/equinox.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/utils/urls.dart';
import 'package:glupe/widgets/carregando.dart';
import 'package:glupe/widgets/loadButton.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool carregando = false;

  mudarEstadoCarregando() {
    setState(() {
      carregando = !carregando;
    });
  }

  bool validarFormulario(){
    if(nomeController.text == "" || emailController.text == "" || senhaController.text == ""){
      return false;
    }
      
    return true;
    

  }

  cadastrar() async {

    
    if(validarFormulario()){
      mudarEstadoCarregando();

      var res = await http
          .post(Uri.parse("${Urls.urlBase}cadastroUsuario.php"), headers: {
        "Accept": "application/json"
      }, body: {
        "nome": nomeController.text,
        "email": emailController.text,
        "senha": senhaController.text,
        "celular": "23452345",
      });

      var obj = json.decode(res.body);
      print(obj);

      mudarEstadoCarregando();
    }else{
      this._showBasicsFlash(duration: Duration(seconds: 3), cor: Cores.melancia, mensagem: "Todos os campos precisam ser preenchidos!");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.noiteAzul,
      key: _key,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 20.0,),

              Text("Cadastro", style: TextStyle(
                                color: Cores.cristaBranca,
                                fontSize: 25.0,
                                fontFamily: 'AvenirBold'),),
              EqTextField(
                controller: nomeController,
                label: 'Nome',
                shape: EqWidgetShape.semiRound,
                hint: 'Nome',
                icon: EvaIcons.personOutline,
                iconPosition: EqPositioning.right,
                enabled: true,
              ),
              SizedBox(height: 10.0,),
              EqTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                label: 'E-mail',
                shape: EqWidgetShape.semiRound,
                hint: 'E-mail',
                icon: EvaIcons.emailOutline,
                iconPosition: EqPositioning.right,
                enabled: true,
              ),
              SizedBox(height: 10.0,),
              EqTextField(
                controller: senhaController,
                label: 'Senha',
                shape: EqWidgetShape.semiRound,
                hint: 'Senha',
                icon: EvaIcons.lockOutline,
                iconPosition: EqPositioning.right,
                enabled: true,
                obscureText: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              carregando
                  ? CarregandoWidget()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        
                        FlatButton(
                          child: Text("Voltar", style: TextStyle(color: Cores.cristaBranca, fontSize: 18.0, fontWeight: FontWeight.bold)),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        
                        EqButton(
                          appearance: EqWidgetAppearance.filled,
                          onTap: () {
                            this.cadastrar();
                            
                          },
                          label: Text('Cadastrar'),
                          size: EqWidgetSize.large,
                          status: EqWidgetStatus.success,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
  void _showBasicsFlash({
    String mensagem,
    Color cor,
    Duration duration,
    flashStyle = FlashStyle.floating,
  }) {
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          backgroundColor: cor,
          position: FlashPosition.top,
          controller: controller,
          style: flashStyle,
          boxShadows: kElevationToShadow[4],
          child: FlashBar(
            message: Text(mensagem, style: TextStyle(
                                color: Cores.cristaBranca,
                                fontSize: 20.0,
                                fontFamily: 'AvenirRegular')),
          ),
        );
      },
    );
  }
}
