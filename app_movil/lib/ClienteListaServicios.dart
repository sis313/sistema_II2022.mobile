import 'package:app_movil/Favoritos.dart';
import 'package:flutter/material.dart';

import 'ComentariosNegocio.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(title: Text("Mis Tiendas"),
          backgroundColor:  Colors.orangeAccent ),
      body: ListView(

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
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>ComentariosNegocio()));
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
                        e.image,
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
                          Row(
                            children: <Widget>[
                              Flexible(
                                  child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffCEA660),
                                ),
                                child: FittedBox(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          servicios[index].nombre,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                        Icon(
                                          servicios[index].favorito
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComentariosNegocio()));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Text(
                                              "Comentarios",
                                              style: TextStyle(
                                                color: Color(0xfff3ede0),
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            5,
                                            (i) => InkWell(
                                              onTap: () {
                                                setState(() {
                                                  servicios[index]
                                                      .calificacion = i + 1;
                                                });
                                              },
                                              child: Icon(
                                                i <
                                                        servicios[index]
                                                            .calificacion
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child:  Icon(Icons.favorite_border),

                              )
                          ),
                        ],
                      ),
                  ),
                ),
                    ),
              )
                  .toList())

        ],
      ),
    );
  }
}