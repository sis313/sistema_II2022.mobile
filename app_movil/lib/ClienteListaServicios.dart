import 'package:app_movil/Favoritos.dart';
import 'package:app_movil/Mapa.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ComentariosNegocio.dart';
import 'DTO/Business.dart';
import 'Inicio.dart';
import 'MenuLateral.dart';
import 'ServicioDetail.dart';

class Product {
  final image;
  final name;
  final price;

  Product(this.image, this.name, this.price);
}






class ClienteListaServicios extends StatelessWidget {
  List products = [
    Product(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
        'Tienda 1',
        5),
    Product(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
        'Tienda 2',
        4),
  ];
  Future<List<Business>> business;

  var ListBusinness;

  void convertFutureListToList() async {
    ListBusinness = await business ;
    print("Lista de negocios> /n $ListBusinness");
  }

  var id;
  final fav =false;

  @override
  Widget build(BuildContext context) {
    business = Provider.of<BoActiveProvider>(context, listen: false).getBusiness();

    return Scaffold(
        backgroundColor: Color(0xfff6f7f9),
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text("Servicios "),
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
                child: GestureDetector(
                  onTap: () {
                    convertFutureListToList();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample(ListBusinness)));
                  },
                  child: Icon(
                    Icons.map_sharp,
                    size: 26.0,
                  ),
                )),
          ],
        ),

        body: FutureBuilder(
          future: business,
          builder: (context, snapshot){
            if(snapshot.hasData){

              return items(snapshot.data, context);
            }
            else if (snapshot.data == null){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
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
                  (e) => GestureDetector(
                onTap:  () {
                  id=e.idBusiness;
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ServicioDetail(id)));
                },
                child: Container(
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
                        Text("\Estrellas :" + e.idBusiness.toString()),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1.0,
                          ),
                          child:  IconButton(
                              onPressed: (){

                                Provider.of<BoActiveProvider>(context, listen: false).addfav(e);
                              },

                              icon: Icon(  Provider.of<BoActiveProvider>(context, listen: false).getFavs().any((element) => e.idBusiness==element.idBusiness)
                                  ? Icons.favorite : Icons.favorite_border,  color: false ? null : Color(0xffa01912))
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                .toList())

      ],
    );
  }
}