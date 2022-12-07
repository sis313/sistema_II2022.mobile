import 'package:app_movil/ClienteListaServicios.dart';
import 'package:app_movil/DTO/TypeBusiness.dart';

import 'package:app_movil/servers/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/MenuLateral.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'DTO/Item.dart';
import 'Servicio.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ClienteServicios extends StatelessWidget {
  /*
  Item item1 = new Item(
      title: "Supermercados",
      subtitle: "Comida,otros",
      event: "15 encontrados",
      img: "assets/supermercado.png");

  Items item2 = new Items(
    title: "Hospitales",
    subtitle: "Bocali, Apple",
    event: "15 encontrados",
    img: "assets/hospital.png",
  );
  Items item3 = new Items(
    title: "Panaderias",
    subtitle: "Lucy Mao going to Office",
    event: "15 encontrados",
    img: "assets/panaderia.png",
  );
  Items item4 = new Items(
    title: "Veterinaria",
    subtitle: "Rose favirited your Post",
    event: "15 encontrados",
    img: "assets/veterinaria.png",
  );
  Items item5 = new Items(
    title: "Farmacias",
    subtitle: "Homework, Design",
    event: "15 encontrados",
    img: "assets/farmacia.png",
  );
  Items item6 = new Items(
    title: "Tiendas de Barrio",
    subtitle: "",
    event: "15 encontrados",
    img: "assets/barrio.png",
  );
   */
  Future<List<TypeBusiness>> myList;

  @override
  Widget build(BuildContext context) {
    myList = Provider.of<BoActiveProvider>(context, listen: false).getTypeBusiness();
    print(myList);
    return FutureBuilder(
      future: myList,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return items(snapshot.data, context);
        }
        else if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget items (List<TypeBusiness> myList, BuildContext context){

    return Flexible(

      child: GridView.count(

          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap:  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ClienteListaServicios()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff85cbcc), borderRadius: BorderRadius.circular(10)),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Image.asset(
                      "assets/barrio.png",
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.name,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),

                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      'little description',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),

                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
