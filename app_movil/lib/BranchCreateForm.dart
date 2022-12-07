import 'package:app_movil/DTO/Municipality.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

import 'BranchDetail.dart';
import 'DTO/City.dart';
import 'DTO/Location.dart';
import 'DTO/Zone.dart';
import 'servers/provider.dart';

class BranchCreateForm extends StatefulWidget {
  int idBusiness;
  BranchCreateForm(this.idBusiness);

  @override
  State<BranchCreateForm> createState() => _BranchCreateFormState(idBusiness);
}

class _BranchCreateFormState extends State<BranchCreateForm> {
  int idBusiness;

  _BranchCreateFormState(this.idBusiness);

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
  var municipalities;
  var zones;

  List<Location> locations;

  Location lugar;

  /*VARIAS IMPORTANTES*/
  int idZone;
  int idLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Branch Creation"),
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
          ElevatedButton(
            onPressed: () async {
              print("address es $address");
              print("openHour es $openTime");
              print("closeHour es $closeTime");
              print("attentionDays es $valueAtencion");
              print("idZone es $idZone");
              print("idLocation es $idLocation");
              print("idBusiness es $idBusiness");

              DateTime now = new DateTime.now();

              //print(openTime.toString());

              var response = Provider.of<BoActiveProvider>(context, listen: false).
              createBranch(
                  address,
                  new DateTime(now.year, now.month, now.day, openTime.hour, openTime.minute),
                  new DateTime(now.year, now.month, now.day, closeTime.hour, closeTime.minute),
                  valueAtencion.toString(),
                  "aW1hZ2UgZmlsZQ==",
                  1,
                  1,
                  idBusiness);


              Route route = MaterialPageRoute(builder: (context) => BranchDetail(idBusiness));
              Navigator.push(context, route);
            },
            child: Text("Guardar"),
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
          Flexible(
              child: FlutterMap(
                options: MapOptions(
                    onTap: (tapPosition, point) async {

                      Coordinates punto = new Coordinates(point.latitude, point.longitude);
                      var addresses = await Geocoder.local.findAddressesFromCoordinates(punto);
                      var first = addresses.first;

                      cities = await Provider.of<BoActiveProvider>(context, listen: false).getCities();
                      municipalities = await Provider.of<BoActiveProvider>(context, listen: false).getMunicipalities();
                      zones = await Provider.of<BoActiveProvider>(context, listen: false).getZones();
                      locations = await Provider.of<BoActiveProvider>(context, listen: false).getLocation();

                      setState(() {
                        address = first.addressLine;
                        zona = first.subLocality;
                        municipio = first.adminArea;
                        ciudad = first.locality;

                        if(municipio == null) municipio = ciudad;
                        if(zona == null) zona = municipio;

                        City city = findCityByName(ciudad, cities);

                        if(city == null){
                          var response = Provider.of<BoActiveProvider>(context, listen: false).createCity(ciudad);
                          city = findCityByName(ciudad, cities);
                        }

                        Municipality municipality = findMunicipalityByName(municipio, municipalities);

                        if(municipality == null){
                          var response = Provider.of<BoActiveProvider>(context, listen: false).
                            createMunicipality(municipio, city.idCity);
                          municipality = findMunicipalityByName(municipio, municipalities);;
                        }

                        Zone zone = findZoneByName(zona, zones);

                        if(zone == null){
                          var response = Provider.of<BoActiveProvider>(context, listen: false).
                          createZone(zona, municipality.idMunicipalities);
                          zone = findZoneByName(zona, zones);
                        }

                        Location location = findLocationByLat(num.parse(point.latitude.toStringAsFixed(8)), locations);

                        /*try{
                          location = findLocationByLat(lat, locations);
                        }on NoSuchMethodError{
                          var response = Provider.of<BoActiveProvider>(context, listen: false).
                          createLocation(lat, log);
                          location = findLocationByLat(lat, locations);
                        }*/

                        //print("Location es $location");

                        if(location == null || (location != null && location.longitude != point.longitude)){
                          /*var response = Provider.of<BoActiveProvider>(context, listen: false).
                          createLocation(num.parse(point.latitude.toStringAsFixed(8)), num.parse(point.longitude.toStringAsFixed(8)));*/

                          createLocation(point.latitude, point.longitude);
                          location = lugar;
                        }

                        /*print("address es $address");
                        print("openHour es $openTime");
                        print("closeHour es $closeTime");
                        print("attentionDays es $valueAtencion");
                        print("idZone es ${zone.idZone}");
                        print("idLocation es ${location.id}");
                        print("idBusiness es $idBusiness");*/

                        try{
                          print("address es $address");
                          print("openHour es $openTime");
                          print("closeHour es $closeTime");
                          print("attentionDays es $valueAtencion");
                          print("idZone es ${zone.idZone}");
                          print("idLocation es ${location.id}");
                          print("idBusiness es $idBusiness");

                          idZone = zone.idZone;
                          idLocation = location.id;

                          /*var response = Provider.of<BoActiveProvider>(context, listen: false).
                          createBranch(
                              address,
                              openTime.toString(),
                              closeTime.toString(),
                              valueAtencion,
                              "https://sistemasii2022.s3.amazonaws.com/ab72364152e34adfa2128b4691a77976",
                              zone.idZone,
                              location.id,
                              idBusiness,
                              now,
                          now);

                          Route route = MaterialPageRoute(builder: (context) => BranchDetail(idBusiness));
                          Navigator.push(context, route);*/
                        }on NoSuchMethodError{
                          print("Lat es ${num.parse(point.latitude.toStringAsFixed(8))} y long es ${num.parse(point.longitude.toStringAsFixed(8))}");
                          print("error lat es ${locations.last.latitude} y long es ${locations.last.longitude}");
                        }
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

  findMunicipalityByName(String name, var municipalities){
    return municipalities.firstWhere((element) =>
    element.name == name, orElse: () {
      return null;
    });
  }

  findZoneByName(String name, var zones){
    return zones.firstWhere((element) =>
    element.name == name, orElse: () {
      return null;
    });
  }

  findLocationByLat(double lat, var locations){
    return locations.firstWhere((element) =>
    element.latitude == lat, orElse: () {
      return null;
    });
  }

  createLocation(double lat, double log) async{
    var response = await Provider.of<BoActiveProvider>(context, listen: false).
    createLocation(num.parse(lat.toStringAsFixed(8)), num.parse(log.toStringAsFixed(8)));

    lugar = response;
  }
}
