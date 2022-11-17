import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

import '../DTO/City.dart';
import '../servers/provider.dart';

class BranchForm extends StatefulWidget {
  @override
  State<BranchForm> createState() => _BranchFormState();
}

class _BranchFormState extends State<BranchForm> {

  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();

  var vectorAtencion = ['Lunes a Viernes', 'Lunes a Sabado', 'Toda la semana'];

  final controllerSucursal = TextEditingController();
  final ctrollerNegocioName = TextEditingController();
  final ctrollerNegocioDesc = TextEditingController();

  String valueAtencion;

  String zona = "";
  String municipio = "";
  String ciudad = "";
  String address = "";

  double lat = 0;
  double log = 0;

  var cities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Branch Info"),
        backgroundColor: Color(0xffa7d676),
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Abre a las : ${openTime.hour}:${openTime.minute}",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 25),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay newTime = openTime;
                  newTime = await showTimePicker(
                      context: context,
                      initialTime: openTime
                  );

                  if(newTime == null) return;

                  setState(() {
                    openTime = newTime;

                    if(openTime.hour >= closeTime.hour)
                      closeTime = openTime;
                  });
                },
                child: Text("Cambiar"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xfffbc78d)
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xfffbc78d))
                        )
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Cierra a las : ${closeTime.hour}:${closeTime.minute}",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 25),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay newTime = closeTime;
                  newTime = await showTimePicker(
                      context: context,
                      initialTime: closeTime
                  );
                  setState(() {
                    if(newTime == null ||
                        (openTime.hour == newTime.hour &&
                            openTime.minute > newTime.minute) ||
                        openTime.hour > newTime.hour)
                      closeTime = openTime;
                    else
                      closeTime = newTime;
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xfffbc78d)
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xfffbc78d))
                        )
                    )),
                child: Text("Cambiar"),

              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Atencion: ",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                  value: valueAtencion,
                  items: vectorAtencion.map(
                          (String e) =>
                          DropdownMenuItem<String>(
                              value: e,
                              child: Text(e)
                          )
                  ).toList(),
                  onChanged: (String value) {
                    setState(() {
                      this.valueAtencion = value;
                    });
                  }
              )
            ],
          ),
          Text("Direccion es $address"),
          Flexible(
              child: FlutterMap(
                options: MapOptions(
                    onTap: (tapPosition, point) async {

                      Coordinates punto = new Coordinates(point.latitude, point.longitude);
                      var addresses = await Geocoder.local.findAddressesFromCoordinates(punto);
                      var first = addresses.first;

                      cities = await Provider.of<BoActiveProvider>(context, listen: false).getCities();

                      setState(() {
                        address = first.addressLine;
                        zona = first.subLocality;
                        municipio = first.adminArea;
                        ciudad = first.locality;

                        City city = findCityByName(ciudad, cities);
                        print(city.name);
                      });
                    },
                    center: LatLng(-16.493730639624058, -68.13252864400924),// Coordenadas Plaza Murillo -16.493730639624058, -68.13252864400924
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
                ],
              )
          )
        ],
      )
    );
  }

  findCityByName(String city, var cities){
    return cities.firstWhere((element) =>
    element.name == city, orElse: () {
      return null;
    });
  }

  findMunicipalityByIdCity(int idcity, var municipalities){
    return municipalities.firstWhere((element) =>
    element.idCity == idcity, orElse: () {
      return null;
    });
  }
}
