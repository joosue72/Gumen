import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Ventas.dart';



class CrearProducto extends StatefulWidget {
  CrearProducto({Key key}) : super(key: key);

  @override
  _ProductoState createState() => _ProductoState();
}

class _ProductoState extends State<CrearProducto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getCustomAppBar(), 
    );
  }

  _getCustomAppBar(){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.deepOrangeAccent,
            Colors.yellowAccent,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Ventas()),
  );

        }),
        Text('Crear Producto', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.create), onPressed: (){}),
      ],),
    ),
  );
}
}

 