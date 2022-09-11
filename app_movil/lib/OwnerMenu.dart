import 'package:flutter/material.dart';
import 'DTO/Negocio.dart';
import 'DTO/Sucursal.dart';

class OwnerMenu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _OwnerMenuState();
}

class _OwnerMenuState extends State<OwnerMenu> {

  //Valor que se mostrara al inicio en el dropdaown menu
  String value = '';

  //Datos de prueba para dropdown
  var categorias = ['', 'Categoria 1', 'Categoria 2', 'Categoria 3'];

  //Datos de prueba para listado
  var negocios = [
    Negocio('Nombre Negocio 1', [Sucursal('Sucursal 1', ''), Sucursal('Sucursal 2', '')]),
    Negocio('Nombre Negocio 2', [Sucursal('Sucursal 1', '')]),
    Negocio('Nombre Negocio 3', [Sucursal('Sucursal 1', '')]),
    Negocio('Nombre Negocio 4', [Sucursal('Sucursal 1', '')]),
    Negocio('Nombre Negocio 5', [Sucursal('Sucursal 1', '')]),
    Negocio('Nombre Negocio 6', [Sucursal('Sucursal 1', '')]),
    // Negocio('Nombre Negocio 7', [Sucursal('Sucursal 1', '')]),
    // Negocio('Nombre Negocio 8', []),
    // Negocio('Nombre Negocio 9', []),
    // Negocio('Nombre Negocio 10', []),
    // Negocio('Nombre Negocio 11', []),
    // Negocio('Nombre Negocio 12', []),
    // Negocio('Nombre Negocio 13', []),
    // Negocio('Nombre Negocio 14', []),
    // Negocio('Nombre Negocio 15', []),
    // Negocio('Nombre Negocio 16', []),
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Mis Negocios'),
            actions: [
              PopupMenuButton<int>(
                  onSelected: (item) => _onSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      AlertDialog(
                                        title: const Text('Nuevo Negocio'),
                                        content: Column(
                                          children: [
                                            const TextField(
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Nombre de Negocio',
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            const TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Descripcion',
                                              ),
                                            ),
                                            DropdownButton<String>(
                                                value: value,
                                                items: categorias.map(
                                                        (String e) =>
                                                        DropdownMenuItem<String>(
                                                            value: e,
                                                            child: Text(e)
                                                        )
                                                ).toList(),
                                                onChanged: (String value) {
                                                  setState(() {
                                                    this.value = value;
                                                  });
                                                }
                                            )
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text('Cancelar')
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text('Registrar')
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                            );
                          },
                          child: const Text('Añadir Negocio'),
                        )
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Salir'),
                    )
                  ]
              )
            ],
          ),
          body: ListView.builder(
            itemCount: negocios.length,
            itemBuilder: (context, index){
              return Card(
                child: negocio(negocios[index]),
              );
            },
          )
      ),
    );
  }

  //Lista de widgets a partir de lista con datos
  List<Widget> listarNegocios(List<Negocio> negocios){

    List<Widget> widgets = [];

    for(int i = 0; i < negocios.length; i++){
      widgets.add(negocio(negocios[i]));
    }

    return widgets;
  }

  Widget negocio(Negocio negocio){

    String nombre = negocio.nombre.toString();
    int sucursales = negocio.sucursales.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Icon(
              Icons.house,
              size: 50,
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Text(
                  'Numero de sucursales ($sucursales)',
                  style: TextStyle(
                      fontSize: 18
                  ),
                )
              ],
            ),
            SizedBox(width: 50),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  setState(() {
                    if(negocio.wState == true)
                      negocio.wState = false;
                    else
                      negocio.wState = true;
                    print(negocio.wState);
                  });
                },
                icon: (negocio.wState ?
                Icon(Icons.indeterminate_check_box_outlined, size: 50) :
                Icon(Icons.add_box_outlined, size: 50))
            )
          ],
        ),
        (negocio.wState ?
        ListView.builder(
            shrinkWrap: true,
            itemCount: sucursales,
            itemBuilder: (_, index){
              return sucursal(negocio.sucursales[index]);
            })
            : SizedBox(height: 0))
      ],
    );
  }

  Widget sucursal (Sucursal sucursal){

    String nombre = sucursal.nombre.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          width: 20,
        ),
        Text(
          nombre,
          style: TextStyle(
              fontSize: 15
          ),
        ),
        SizedBox(
          height: 25,
          width: 190,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                icon: Icon(Icons.edit)
            ),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                icon: Icon(Icons.delete_outline)
            )
          ],
        )
      ],
    );
  }

  void _onSelected(BuildContext context, int item){
    switch(item){
      case 0:
        print('Seleccionado Añadir Negocio');
        break;

      case 1:
        print('Seleccionado Salir');
        break;
    }
  }
}
