import 'package:app_movil/RoleMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/MenuLateral.dart';
import 'Servicio.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClienteListaServicios extends StatefulWidget {
  @override
  _ClienteListaServicios createState() => _ClienteListaServicios();
}

class _ClienteListaServicios extends State<ClienteListaServicios> {
  _cargarFavoritos() async {
    servicios = [
      servicio("1", 'panaderia', 213, 'holaa', 'panaderia', 'as', false, 0),
      servicio("2", 'panaderia', 213, 'holaa', 'panaderia', 'as', false, 0),
      servicio("3", 'panaderia', 213, 'holaa', 'panaderia', 'as', false, 0)
    ];
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList("favoritos");
    if (items != null) {
      for (var fav in items) {
        for (var serv in servicios) {
          if (serv.id == fav) {
            serv.favorito = true;
            break;
          }
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _cargarFavoritos();
    super.initState();
  }

  List<servicio> servicios = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text('Categorias'),
        backgroundColor: Color(0xff6B7A40),
      ), //AppBar
      //backgroundColor: Color(0xfff3ede0),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: servicios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        print("press servicio");
                        final prefs = await SharedPreferences.getInstance();
                        List<String> fav = [];
                        servicios[index].favorito = !servicios[index].favorito;
                        for (var serv in servicios) {
                          if (serv.favorito) {
                            fav.add(serv.id);
                          }
                        }
                        await prefs.setStringList("favoritos", fav);
                        setState(() {});
                      },
                      child: Column(
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
                                ),
                              )),
                              SizedBox(
                                height: 150,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            )
          ], //<Widget>[]
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ), //Column
      ) //Padding
          ),
    );
  }
}
