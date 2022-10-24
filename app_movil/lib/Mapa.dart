import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'DTO/Negocio.dart';
import 'DTO/Sucursal.dart';

class MapSample extends StatefulWidget {
  //const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  var user_position ;
  bool showUser = false;

  @override
  void initState() {
    super.initState();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("$position.latitude, $position.longitude ");
    //var user = [position.latitude, $position.longitude];
    setState(() {
      user_position  = position;
      showUser = true;
    });
  }

  //Datos de prueba para listado
  var negocios = [
    Negocio(1, 'Nombre Negocio 1', [Sucursal(1, 'Sucursal 1', ''), Sucursal(2, 'Sucursal 2', '')]),
    Negocio(2, 'Nombre Negocio 2', [Sucursal(3, 'Sucursal 1', '')]),
    Negocio(3, 'Nombre Negocio 3', [Sucursal(4, 'Sucursal 1', '')]),
    Negocio(4, 'Nombre Negocio 4', [Sucursal(5, 'Sucursal 1', '')]),
    Negocio(5, 'Nombre Negocio 5', [Sucursal(6, 'Sucursal 1', '')]),
    Negocio(6, 'Nombre Negocio 6', [Sucursal(7, 'Sucursal 1', '')]),
  ];

  @override
  Widget build(BuildContext context) {

    final elevButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 10,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
                child: FlutterMap(
                  options: MapOptions(// Coordenadas Plaza Murillo -16.493730639624058, -68.13252864400924
                    center: LatLng(-16.493730639624058, -68.13252864400924),
                      zoom: 12,
                      maxZoom: 18,
                      minZoom: 12
                  ),
                  nonRotatedChildren: [
                    AttributionWidget.defaultWidget(
                      source: 'OpenStreetMap contributors',
                      onSourceTapped: null,
                    ),
                    Align(
                    alignment: Alignment(0.9, 0.9),
                    child:
                    ElevatedButton(
                      child: const Icon(
                        Icons.adjust_sharp,
                        color: Colors.white,
                        size: 40,
                      ),
                      style: elevButtonStyle,
                      onPressed: () {
                        getCurrentLocation();
                      },),
                  )],

                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        //getMarkerUser(showUser, user_position),
                      showUser != false ?
                        Marker(
                        point: LatLng(user_position.latitude, user_position.longitude),
                          builder: (context) => Icon(
                          Icons.person_pin,
                          color: Colors.red,
                          size: 50,
                          )
                        ):
                        Marker(
                            point: LatLng(-16.493730639624058, -68.13252864400924),
                            builder: (context) => Icon(
                              Icons.pin_drop_rounded,
                              color: Colors.red,
                              size: 50,
                            )
                        ),

                        //Plaza Abaroa -16.509119931820113, -68.12710156327141
                        Marker(
                            point: LatLng(-16.509119931820113, -68.12710156327141),
                            builder: (context) => IconButton(
                                onPressed: (){
                                 // getCurrentLocation();
                                  //print();
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              AlertDialog(
                                                title: const Text('Sucursal ###'),
                                                content: Column(
                                                  children: [
                                                    Text("Info 1"),
                                                    Text("Info 2"),
                                                    Text("Info 3"),
                                                  ],
                                                ),
                                                /*actions: [
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: const Text('Cancelar')
                                                  ),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: const Text('Eliminar')
                                                  ),
                                                ],*/
                                              )
                                            ],
                                          );
                                        }
                                    );
                                  });
                                },
                                icon: Icon(Icons.pin_drop, size: 30,)
                            )
                        ),
                        //Plaza Uyuni -16.496729596124986, -68.1243340897443
                        Marker(
                          point: LatLng(-16.496729596124986, -68.1243340897443),
                          builder: (context) => GestureDetector(
                              onTap: (){
                                print("Plaza uyuni");
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            AlertDialog(
                                              title: const Text('Sucursal ###'),
                                              content: Column(
                                                children: [
                                                  Text("Info 1"),
                                                  Text("Info 2"),
                                                  Text("Info 3"),
                                                ],
                                              ),
                                              /*actions: [
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: const Text('Cancelar')
                                                  ),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: const Text('Eliminar')
                                                  ),
                                                ],*/
                                            )
                                          ],
                                        );
                                      }
                                  );
                                });
                              },
                              child: Icon(Icons.pin_drop, size: 50,)
                          ),
                        )
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );

  }

  info (Sucursal sucursal) {
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: Text(sucursal.nombre),
                content: Column(
                  children: [
                    Text(sucursal.direccion),
                    Text("Info 2"),
                    Text("Info 3"),
                  ],
                )
              )
            ],
          );
        }
    );
  }


}
