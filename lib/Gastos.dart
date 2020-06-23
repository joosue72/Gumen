import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'Menu.dart';


class Gastos extends StatefulWidget {
  Gastos({Key key}) : super(key: key);

  @override
  _GastosState createState() => _GastosState();
}

String nombre;
double cantidad;
String descripcion;
DateTime now = DateTime.now();
String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

class _GastosState extends State<Gastos> {

  String id;
  final db = Firestore.instance;
  final _formKey7 = GlobalKey<FormState>();
  final _formKey8 = GlobalKey<FormState>();
  final _formKey9 = GlobalKey<FormState>();
  final _formKey10 = GlobalKey<FormState>();

   TextFormField buildTextFormFieldNombre() {
    return TextFormField(
      
    keyboardType: TextInputType.multiline,
    minLines: 1,//Normal textInputField will be displayed
    maxLines: 5,// when user presses enter it will adapt to it
    
      decoration: InputDecoration(
        
        labelText: 'Nombre',
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
  TextFormField buildTextFormFieldCosto() {
    return TextFormField(
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
        
        labelText: 'Costo',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => cantidad = double.tryParse(value),
    );
    
  }
   TextFormField buildTextFormFieldFecha() {
   
    return TextFormField(
      decoration: InputDecoration(
        
        labelText: fecha,
        prefixText: now.toString(),
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => fecha = value,
    );
  }
  TextFormField buildTextFormFieldDescripcion() {
    return TextFormField(
      
    keyboardType: TextInputType.multiline,
    minLines: 1,//Normal textInputField will be displayed
    maxLines: 5,// when user presses enter it will adapt to it
    
      decoration: InputDecoration(
        
        labelText: 'Descripcion',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => descripcion = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      appBar: _getCustomAppBar(),
      body: ListView(
       
        padding: EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(height: 50.0),
          Form(
            key: _formKey7,
            child: buildTextFormFieldNombre(),
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey8,
            child: buildTextFormFieldCosto(),
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey9,
            child: buildTextFormFieldDescripcion(),
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey10,
            child: buildTextFormFieldFecha(),
          ),
          
          
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              ButtonTheme(
                
                minWidth: 250.0,
                height: 50.0,
                child: RaisedButton(
    color: Colors.blueAccent, 
    child: Row( 
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max, 
    children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
              "Generar Gasto",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.send, 
          color: Colors.white,
          size: 18, 
        ),
    ],
    ),
            onPressed: () {
                 Route route = MaterialPageRoute(builder: (bc) => HomeScreen());
                               Navigator.of(context).push(route);
                               createData(); 
            },
),
              )
            ],
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
            Colors.blueAccent,
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
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );

        }),
        Text('Gastos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.monetization_on), onPressed: (){}),
      ],),
    ),
  );
}

void createData() async {
    if (_formKey7.currentState.validate() || _formKey8.currentState.validate() || _formKey9.currentState.validate() || _formKey10.currentState.validate()) {
      _formKey7.currentState.save();
      _formKey8.currentState.save();
      _formKey9.currentState.save();
      _formKey10.currentState.save();
      String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
      DocumentReference ref = await db.collection('Gastos').add({'Nombre': '$nombre', 'Precio': '$cantidad', 'Descripcion': '$descripcion', 'Fecha': '$fecha'});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }



}