import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'DTO/Negocio.dart';
import 'DTO/Sucursal.dart';

class MapSample extends StatefulWidget {
  //const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

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
                  ],
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            point: LatLng(-16.493730639624058, -68.13252864400924),
                            builder: (context) => Icon(
                              Icons.pin_drop_rounded,
                              color: Colors.red,
                              size: 30,
                            )
                        ),
                        //Plaza Abaroa -16.509119931820113, -68.12710156327141
                        Marker(
                            point: LatLng(-16.509119931820113, -68.12710156327141),
                            builder: (context) => IconButton(
                                onPressed: (){
                                  print("Boton Abaroa");
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
                              child: Icon(Icons.pin_drop, size: 30,)
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
                title: Text(sucursal.name),
                content: Column(
                  children: [
                    Text(sucursal.address),
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