import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Nomina.dart';

 class NuevoEmpleado extends StatefulWidget {
  NuevoEmpleado({Key key}) : super(key: key);

  @override
  _NuevoEmpleadoState createState() => _NuevoEmpleadoState();
}

final db = Firestore.instance;
  String id;
  String nombre;
  TextEditingController _textFieldController = TextEditingController();

class _NuevoEmpleadoState extends State<NuevoEmpleado> {

  TextFormField buildTextFormFieldNombre() {
  
    return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textFieldController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFFF4511E)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.storage),
                 hintText: "Nuevo Empleado",
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
    color: Color(0xFFF4511E), 
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
                 Route route = MaterialPageRoute(builder: (bc) => Nomina());
                               Navigator.of(context).push(route);
                               nombre = _textFieldController.text.toString();
                               Firestore.instance.collection('NombresNomina').document("$nombre").setData({'Nombre': '$nombre'});                        
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
            Color(0xFFF4511E),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Nomina()),
    
  );

        }),
        Text('Nuevo Empleado', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.person_add), onPressed: (){}),
      ],),
    ),
  );
}
}