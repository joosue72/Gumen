
import 'package:gumen/Ventas.dart';
import 'package:gumen/models/empleado_model.dart';
import 'package:flutter/material.dart';
import 'package:gumen/RegistroCliente.dart';

import 'package:gumen/providers/empleados_provider.dart';

class Empleados extends StatefulWidget {
  
  Empleados({Key key}) : super(key: key);

  @override
  _EmpleadosState createState() => _EmpleadosState();
}

class _EmpleadosState extends State<Empleados> {
  final empleadosProvider = new ClientesProvider();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        
        
        title: Text('Lista de Empleados'),
        backgroundColor: Colors.orange
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton( context ),
    );
  }


  Widget _crearListado(){

   

    return FutureBuilder(
      
      future: empleadosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
        if(snapshot.hasData)
        {
          final empleados = snapshot.data;
          return ListView.builder(
            itemCount: empleados.length ,//saber cuantas veces va a repetir
            itemBuilder: (context,i) => _crearItem(empleados[i]),
            );
        }
        else
        {
          return Center(child: CircularProgressIndicator());
        }
      },
    );


  }


  Widget _crearItem(Client empleado){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red,),
      onDismissed: (direccion){
        empleadosProvider.borrarEmpleado(empleado.id);          //borrar Producto
      },
          child: Card(
            child: Column(
              children: <Widget>[
                (empleado.fotoUrl == null)
                ? Image(image: AssetImage('images/no-image.png'))
                : FadeInImage(image: NetworkImage(empleado.fotoUrl),
                              placeholder: AssetImage('images/original.gif'),
                              height: 300.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                ),
                ListTile(
        title: Text('${empleado.nombrecompleto}-${empleado.sueldo}'),
        subtitle: Text(empleado.id),
         onTap: () => Navigator.pushNamed(context, 'Empleado', arguments: empleado ),
      ),

              ],
            ),
          )
    );
  }

 

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.orange,
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => RegistroCliente());
         Navigator.of(context).push(route);
         },
    );
  }
}