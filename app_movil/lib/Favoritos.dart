import 'package:app_movil/DTO/Business.dart';
import 'package:app_movil/Favoritos.dart';
import 'package:app_movil/Mapa.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'DTO/Rating.dart';
import 'Inicio.dart';
import 'MenuLateral.dart';



class Favoritos extends StatelessWidget {

  List<Business> business;
  var ListBusinness;
  final alreadyadd =false;

  void convertFutureListToList() async {
    ListBusinness = await business ;
    print("Lista de negocios> /n $ListBusinness");
  }

  var id;
  @override
  Widget build(BuildContext context) {
    business = Provider.of<BoActiveProvider>(context, listen: false).getFavs();

    return Scaffold(
        backgroundColor: Color(0xfff6f7f9),
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text("Mis favoritos "),
          backgroundColor: Color(0xffa7d676),
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
               ),
          ],
        ),

        body:  items(business, context)
    );
  }

  Widget items(List<Business> products, BuildContext context){
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          height: 20,

        ),
        Column(

            children: products
                .map(
                  (e) =>
                Container(
                  margin:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: Offset(3, 4))
                    ],
                  ),

                  child: ListTile(
                    leading: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 100,
                    ),
                    title: Text(
                      e.name,
                      style: TextStyle(fontSize: 25),
                    ),

                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("\Sucursal :" + e.idBusiness.toString()),
                        SizedBox(height: 10),



                      ],
                    ),
                  ),
                ),

            )
                .toList())

      ],
    );
  }
}