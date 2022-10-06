import 'package:app_movil/ClienteListaServicios.dart';
import 'package:app_movil/RoleMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/MenuLateral.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Servicio.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ClienteServicios extends StatelessWidget {
  Items item1 = new Items(
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

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    //
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
                color: Color(0xff8b9d43), borderRadius: BorderRadius.circular(10)),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Image.asset(
                  data.img,
                  width: 42,
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  data.title,
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
                  data.subtitle,
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
                  data.event,
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

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
