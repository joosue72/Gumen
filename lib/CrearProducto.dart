import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Ventas.dart';



class CrearProducto extends StatefulWidget {
  CrearProducto({Key key}) : super(key: key);

  @override
  _ProductoState createState() => _ProductoState();
}

  final db = Firestore.instance;
  String id;
  final _formKeyproducto = GlobalKey<FormState>();
 
  String producto;


class _ProductoState extends State<CrearProducto> {


TextFormField buildTextFormFieldNombre() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.storage,
          color: Colors.black,
        ),
        labelText: 'Producto',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => producto = value,
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
            key: _formKeyproducto,
            child: buildTextFormFieldNombre(),
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
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
                               //createData(); 
                               db.collection('VentasProducto').document(producto).setData({'Producto': '$producto'});              
            },
),
              ),
              
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

void createData() async {
    if (_formKeyproducto.currentState.validate()) {
      _formKeyproducto.currentState.save();
      

      
      DocumentReference ref = await db.collection('VentasProducto').document(producto);
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }


}

 