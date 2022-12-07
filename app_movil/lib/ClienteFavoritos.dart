
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/MenuLateral.dart';
import 'Servicio.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClienteFavoritos extends StatefulWidget {
  @override
  _ClienteFavoritos createState() => _ClienteFavoritos();
}

class _ClienteFavoritos extends State<ClienteFavoritos> {
  _cargarFavoritos() async {
    var serviciosAux = [
      servicio("1", 'panaderia', 213, 'holaa', 'panaderia', 'as', false, 0),
      servicio("2", 'panaderia', 213, 'holaa', 'panaderia', 'as', false, 0),
      servicio("3", 'panaderia', 213, 'holaa', 'panaderia', 'as', false, 0)
    ];
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList("favoritos");
    if (items != null) {
      for (var fav in items) {
        for (var serv in serviciosAux) {
          if (serv.id == fav) {
            serv.favorito = true;
            servicios.add(serv);
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
                      onTap: () async {},
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
                                          Icons.favorite,
                                          color: Colors.red,
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
