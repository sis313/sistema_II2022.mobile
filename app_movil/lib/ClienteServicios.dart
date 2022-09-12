import 'package:app_movil/ClienteListaServicios.dart';
import 'package:app_movil/RoleMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/MenuLateral.dart';
import 'Servicio.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ClienteServicios extends StatefulWidget {
  @override
  _ClienteServicios createState() => _ClienteServicios();
}

class _ClienteServicios extends State<ClienteServicios> {
  _cargarFavoritos() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<servicio> _vlam;
    List<String> categorias = [
      'Hospitales',
      'Restaurantes',
      'entretenimiento',
      'Educación',
      'Bares'
    ];
    List<Icon> icon = [
      Icon(Icons.local_hospital),
      Icon(Icons.restaurant),
      Icon(Icons.movie_creation_outlined),
      Icon(Icons.account_balance),
      Icon(Icons.local_drink)
    ];
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text('Categorias 2'),
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
                  scrollDirection: Axis.vertical,
                  itemCount: categorias.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        print("press button");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClienteListaServicios()));
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
                                            categorias[index].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          Icon(
                                            icon[index].icon,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
