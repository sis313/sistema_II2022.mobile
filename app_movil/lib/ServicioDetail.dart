// ignore_for_file: prefer_const_constructors

import 'package:app_movil/ClienteListaServicios.dart';
import 'package:app_movil/ComentariosNegocio.dart';
import 'package:app_movil/DTO/TypeBusiness.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'DTO/Business.dart';
import 'DTO/Comment.dart';

class Product {
  final image;
  final name;
  final price;
  final calificacion;

  Product(this.image, this.name, this.price,this.calificacion);
}

class ServicioDetail extends StatefulWidget {
final int id;


ServicioDetail(this.id);

  @override
  State<ServicioDetail> createState() => _ServicioDetailState();
}

class _ServicioDetailState extends State<ServicioDetail> {


  Future<List<Business>> business;

  

  @override
  Widget build(BuildContext context) {

    business = Provider.of<BoActiveProvider>(context, listen: false).getBusinessById(widget.id) ;
    print('object');
    print(business.toString());
    return Scaffold(
      backgroundColor:Color(0xfff6f7f9),
      appBar: AppBar(
          title: Text("Detalle"),
        backgroundColor: Color(0xffa7d676),
        elevation: 0,
        leading: IconButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>ClienteListaServicios()));},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {      Comment a= Comment();

              Navigator.push(context, MaterialPageRoute(builder: (context) =>ComentariosNegocio(widget.id)));

            },
            icon: const Icon(
              Ionicons.chatbox,
              color: Colors.white,
            ),
          ),
        ],
      ),
    body: FutureBuilder(
        future: Provider.of<BoActiveProvider>(context, listen: false).getBusinessById(widget.id) ,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return items(snapshot.data, context);
          }
          else if (snapshot.data == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
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

  Widget items(List<Business> products, BuildContext context){
    print('------------------------');
    print('desde deatil');
print(products.length);
return   Column(

      mainAxisSize: MainAxisSize.min,
      children: products

          .map(

              (e) =>

                Column(
                  mainAxisSize: MainAxisSize.min,

        children: <Widget> [

          Flexible(
            fit: FlexFit.loose,
            child: Container(

              height: MediaQuery.of(context).size.height*0.30,


              padding: const EdgeInsets.only(bottom: 20),

              width: double.infinity,

              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU'),

            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: Stack(

              children:<Widget> [
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(

                          e.name,

                          style: TextStyle(fontSize: 15.0,color: Colors.grey),

                        ),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Text(

                              e.name,

                              style: TextStyle(fontSize: 22.0),

                            ),



                          ],

                        ),

                        const SizedBox(height: 10),

                        Text(

                          e.description,

                          style: TextStyle(fontSize: 16.0,color: Colors.grey),

                        ),

                      ],

                    ),

                  ),

                ),



              ],

            ),

          ),



        ],

      ),).toList()


);
  }

}