import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumen/Proveedores.dart';

class CrearProveedor extends StatefulWidget {
  CrearProveedor({Key key}) : super(key: key);

  @override
  _CrearProveedorState createState() => _CrearProveedorState();
}

 final db = Firestore.instance;
 String id;
 String nombre;
 TextEditingController _textFieldController = TextEditingController();

class _CrearProveedorState extends State<CrearProveedor> {

  TextFormField crearnuevoProveedor() {
  
    return TextFormField(
      controller: _textFieldController,
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        labelText: 'Proveedor',
        fillColor: Colors.white,
        
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => nombre = value,
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
            child: crearnuevoProveedor(),
          ),
          SizedBox(height: 50.0),
          ButtonTheme(
                
                minWidth: 250.0,
                height: 50.0,
                child: RaisedButton(
    color: Color(0xFF64DD17), 
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
                 Route route = MaterialPageRoute(builder: (bc) => Proveedores());
                               Navigator.of(context).push(route);
                               nombre = _textFieldController.text.toString();
                               Firestore.instance.collection('NombresProveedores').document("$nombre").setData({'NombreProveedor': '$nombre'});                        
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
            Color(0xFF64DD17),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Proveedores()),
    
  );

        }),
        Text('Nuevo Proveedor', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.create), onPressed: (){}),
      ],),
    ),
  );
}
}