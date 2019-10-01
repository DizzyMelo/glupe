import 'package:flutter/material.dart';
import 'package:glupe/cores/index.dart';
import 'package:glupe/navegacao/index.dart';
import 'package:glupe/utils/urls.dart';

class ImagemUsuario extends StatelessWidget {
  String imagem;
  ImagemUsuario(this.imagem);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navegacao.navegarParaPerfil(context);
      },
      child: Container(
                    height: 80.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                        color: Cores.ceuAzulClaro,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Cores.ceuAzulProfundo,
                            offset: new Offset(0.0, 5.0),
                            blurRadius: 10.0,
                          )
                        ],
                        image: DecorationImage(
                            image:
                                NetworkImage('${Urls.imgUsuario}${imagem}'),
                            fit: BoxFit.cover)),
                  ),
    );
  }
}