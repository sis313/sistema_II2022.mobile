import 'package:app_movil/ClienteFavoritos.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/Perfil.dart';

import 'Favoritos.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'nombre',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text('Correo', style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.asset(
                'assets/usuario.png',
                fit: BoxFit.cover,
              )),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/direccion1.gif'))),
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("Perfil"),
<<<<<<< HEAD
            onTap: () {
              //TODO perfil aca
=======
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
>>>>>>> Favoritos
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text("Favoritos"),
<<<<<<< HEAD
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ClienteFavoritos()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text("Favoritos2"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ClienteFavoritos()));
=======
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Favoritos()));
>>>>>>> Favoritos
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back_sharp),
            title: Text("Salir"),
            onTap: () {
              //TODO salir aca
            },
          )
        ],
      ),
    );
  }
}
