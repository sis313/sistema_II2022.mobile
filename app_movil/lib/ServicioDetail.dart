// ignore_for_file: prefer_const_constructors

import 'package:app_movil/ClienteListaServicios.dart';
import 'package:app_movil/ComentariosNegocio.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

class Product {
  final image;
  final name;
  final price;
  final calificacion;

  Product(this.image, this.name, this.price,this.calificacion);
}

class ServicioDetail extends StatelessWidget {

  List products = [
    Product(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
        'Tienda 1',
        5,0),
    Product(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
        'Tienda 2',
        4,0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xfff6f7f9),
      appBar: AppBar(
        backgroundColor: Color(0xffa7d676),
        elevation: 0,
        leading: IconButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>ClienteListaServicios()));},
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {        Navigator.push(context, MaterialPageRoute(builder: (context) =>ComentariosNegocio()));
            },
            icon: const Icon(
              Ionicons.chatbox,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU'),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipo de servicio',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'NOmbre de serviciP',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor consectetur tortor vitae interdum.',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Color(0xfff6f7f9)),
              ),


            ),
            GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1.0,

                  ),

                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),


                )
            ),
            SizedBox(width: 20),

          ],
        ),
      ),
    );
  }
}