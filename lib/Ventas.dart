
import 'CrearProducto.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'VentasPendientes.dart';
import 'package:intl/intl.dart';
import 'Menu.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';


class Ventas extends StatefulWidget {
  //bool pendiente = false; //lo acabo de poner lol
  @override
  _VentasState createState() => _VentasState();
}

String nombre;
double cantidad;
double costo;
String producto;
DateTime now = DateTime.now();
String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
String mes = DateFormat('MMM').format(now);
String nombres;
var selectedCurrency, selectedType;




class _VentasState extends State<Ventas> {

  
  final db = Firestore.instance;
  String id;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  bool pendiente;
  
  @override
  void initState() {
    pendiente = Global.shared.pendiente;
    super.initState();
    
  }


  

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
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
  TextFormField buildTextFormFieldProducto() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.storage,
          color: Colors.white,
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
  TextFormField buildTextFormField1() {
    return TextFormField(
      keyboardType: TextInputType.number,
      
      decoration: InputDecoration(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
         labelText: 'Cantidad',
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

  TextFormField buildTextFormFieldCosto() {
    return TextFormField(
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
        icon: Icon(
          Icons.monetization_on,
          color: Colors.white,
        ),
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
      onSaved: (value) => costo = double.tryParse(value),
    );
    
  }
  
 

  TextFormField buildTextFormFieldFecha() {
   
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.date_range,
          color: Colors.white,
        ),
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
  


  @override
  Widget build(BuildContext context) {
    
     return Scaffold(
        resizeToAvoidBottomInset: false,
       backgroundColor: Colors.black,
      appBar: _getCustomAppBar(),
      body: ListView(
       
        padding: EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(height: 50.0),
          Form(
            key: _formKey,
            child: buildTextFormField(),
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey3,
            child:  ListView(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.storage, color: Colors.white),
                    SizedBox(width: 55.0,),
                     StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('VentasProducto').snapshots(),
                  
                  builder: (context, snapshot) {
                    
                    if (!snapshot.hasData)

                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              
                              snap.reference.documentID,
                              style: TextStyle(color: Color.fromARGB(255,98,97,97)),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          
                          DropdownButton(
                            
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Producto: $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                  
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Producto",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  
                  SizedBox(width: 10.0,),
                   Container(
        height: 40.0,
        width: 40.0,
        child: FittedBox(
        
         child: FloatingActionButton(
           
            child: Icon( Icons.add ),
            backgroundColor: Colors.orange,
      
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => CrearProducto());
         
         Navigator.of(context).push(route);
         },
    ),
        ),
                  ),
                  SizedBox(width: 10.0,),
                  ],
                  
                ),
                
              ],
            ),
             
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey1,  
            child: buildTextFormField1(),
            
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey2,  
            child: buildTextFormFieldCosto(),
            
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey4,  
            child: buildTextFormFieldFecha(),
            
          ),
          SizedBox(height: 20.0),
          Form(
            key: _formKey5,  
            
            child:LiteRollingSwitch(
    //initial value
     
    value: true,
    textOn: 'Pagado',
    textOff: 'Pendiente',
    colorOn: Colors.greenAccent[700],
    colorOff: Colors.redAccent[700],
    iconOn: Icons.done,
    iconOff: Icons.remove_circle_outline,
    textSize: 16.0,
    
    onChanged: (bool isOn) {
      
            pendiente = isOn;
             Global.shared.pendiente = isOn;
             isOn = isOn;
        print(isOn); 
    },
    
    
), 
          ),
          SizedBox(height: 40.0),
          
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
              "Generar",
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
                 Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               Navigator.of(context).push(route);
                               createData(); 
                                               
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
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );

        }),
        Text('Ventas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.monetization_on), onPressed: (){}),
      ],),
    ),
  );
}

   void createData() async {
    if (_formKey.currentState.validate() || _formKey1.currentState.validate() || _formKey2.currentState.validate() || _formKey3.currentState.validate() || _formKey4.currentState.validate() || _formKey5.currentState.validate()) {
      _formKey.currentState.save();
      _formKey1.currentState.save();
      _formKey2.currentState.save();
      _formKey3.currentState.save();
      _formKey4.currentState.save();
      _formKey5.currentState.save();
      String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
      String mes = DateFormat('MMM').format(now);
      int numerofecha;

      switch(mes)
      {
        case 'Jan':
            numerofecha = 1;
        break;
        case 'Feb':
            numerofecha = 2;
        break;
        case 'Mar':
            numerofecha = 3;
        break;
        case 'Apr':
            numerofecha = 4;
        break;
        case 'May':
            numerofecha = 5;
        break;
        case 'Jun':
            numerofecha = 6;
        break;
        case 'Jul':
            numerofecha = 7;
        break;
        case 'Aug':
            numerofecha = 8;
        break;
        case 'Sep':
            numerofecha = 9;
        break;
        case 'Oct':
            numerofecha = 10;
        break;
        case 'Nov':
            numerofecha = 11;
        break;
        case 'Dec':
            numerofecha = 12;
        break;
      }
      DocumentReference ref = await db.collection('Ventas').add({'Nombre': '$nombre', 'Cantidad': '$cantidad', 'Costo': costo, 'Fecha': '$fecha','Producto': '$selectedCurrency', 'pendiente': '$pendiente', 'Mes': numerofecha});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('Ventas').document(id).get();
    print(snapshot.data['Nombre']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).updateData({'Nombre': 'Pagado'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).delete();
    setState(() => id = null);
  }
  

}

class Global{
  static final shared =Global();
  bool pendiente = false;
}

