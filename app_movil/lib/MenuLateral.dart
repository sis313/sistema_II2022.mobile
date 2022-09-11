import 'package:flutter/material.dart';
class MenuLateral extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(accountName: Text('nombre',style: TextStyle(color: Colors.black),), accountEmail: Text('Correo',style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(child: ClipOval(
            child: Image.asset('assets/usuario.png',fit: BoxFit.cover,)
          ),
          ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/direccion1.gif')
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("Perfil"),
            onTap: (){
              //TODO perfil aca
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text("Favoritos"),
            onTap: (){
              //TODO favoritos aca
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back_sharp),
            title: Text("Salir"),
            onTap: (){
              //TODO salir aca
            },
          )
        ],

      ),
    );
  }
}
