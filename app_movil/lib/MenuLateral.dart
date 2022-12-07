import 'package:app_movil/ClienteFavoritos.dart';
import 'package:app_movil/DTO/User.dart';
import 'package:app_movil/StartMenu.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/Perfil.dart';
import 'package:provider/provider.dart';

import 'Favoritos.dart';
import 'Inicio.dart';
import 'Mapa.dart';

class MenuLateral extends StatelessWidget {
  User usuario;
  @override
  Widget build(BuildContext context) {
    usuario=  Provider.of<BoActiveProvider>(context, listen: false).getUser();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              usuario.nickname,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(usuario.email, style: TextStyle(color: Colors.black)),

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/banner.png'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("Perfil"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Perfil()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text("Favoritos"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favoritos()));
            },
          ),
         /* ListTile(
            leading: Icon(Icons.map_sharp),
            title: Text("Mapa"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MapSample()));
            },
          ),*/
          ListTile(
            leading: Icon(Icons.arrow_back_sharp),
            title: Text("Salir"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => StartMenu()));
            },
          )
        ],
      ),
    );
  }
}
