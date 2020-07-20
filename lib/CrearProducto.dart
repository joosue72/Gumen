import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Ventas.dart';
import 'package:flutter/widgets.dart';


class CrearProducto extends StatefulWidget {
 
  @override
  _ProductoState createState() => _ProductoState();
}

  final db = Firestore.instance;
  String id;
  //final GlobalKey<FormState> _riKey1 = new GlobalKey<FormState>();
  String producto;
  TextEditingController _textFieldController = TextEditingController();

class _ProductoState extends State<CrearProducto> {


TextFormField buildTextFormFieldNombre() {
  
    return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textFieldController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFFFFC107)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.storage),
                 hintText: "Crear Producto",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      appBar: _getCustomAppBar(), 
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[

          SizedBox(height: 200.0),
          Form(
            
            //key: _riKey1,
            child: buildTextFormFieldNombre(),
          ),
          SizedBox(height: 50.0),
          ButtonTheme(
                
                minWidth: 250.0,
                height: 50.0,
                child: RaisedButton(
    color: Colors.orange, 
    child: Row( 
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max, 
    children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
              "Crear",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.create_new_folder, 
          color: Colors.white,
          size: 20, 
        ),
    ],
    ),
            onPressed: () {
                 Route route = MaterialPageRoute(builder: (bc) => Ventas());
                               Navigator.of(context).push(route);
                               producto = _textFieldController.text.toString();
                               Firestore.instance.collection('VentasProducto').document("$producto").setData({'Producto': '$producto', 'Cantidad': 0});                        
            },
),
              ),
        
        ],
        
      ),
      
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
            Color(0xFFFFC107),
            Color(0xFFFFE57F),
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

 