import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'MenuNominas.dart';
import 'CrearEmpleado.dart';

 class Nomina extends StatefulWidget {
  Nomina({Key key}) : super(key: key);

  @override
  _NominaState createState() => _NominaState();
}

var selectedCurrency1, selectedType1;
final db = Firestore.instance;
  String id;
  DateTime now = DateTime.now();
String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
double cantidad;
TextEditingController _textPago = TextEditingController();

class _NominaState extends State<Nomina> {

  TextFormField pagoNomina() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _textPago,
      decoration: InputDecoration(
        icon: Icon(
          Icons.attach_money,
          color: Colors.black,
        ),
         labelText: 'Pago',
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       backgroundColor: Colors.white,
      appBar: _getCustomAppBar(),
       body: ListView(
       
        padding: EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(height: 50.0),
          Form(
            //Nombre
            child:  ListView(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 55.0,),
                     StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('NombresNomina').snapshots(),
                  
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
                                  'Empleado: $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency1 = currencyValue;
                              });
                            },
                            value: selectedCurrency1,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Empleado",
                              style: TextStyle(color: Colors.black),
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
            backgroundColor: Color(0xFFF4511E),
      
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => NuevoEmpleado());
         
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
            
            child: pagoNomina(),
          ),
         

          
          SizedBox(height: 40.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
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
                 Route route = MaterialPageRoute(builder: (bc) => MenuNominas());
                               Navigator.of(context).push(route);
                              
                               createData();  


     _textPago.text = "";            
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
    MaterialPageRoute(builder: (context) => MenuNominas()),
    
  );

        }),
        Text('Empleados', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.people), onPressed: (){}),
      ],),
    ),
  );
}
void createData() async {
    
      
     
      cantidad = double.parse(_textPago.text);
      
      String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

      String mes = DateFormat('MMM').format(now);
      String dia = DateFormat('d').format(now);
      String ano = DateFormat('EEE').format(now);
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
      
      DocumentReference ref = await db.collection('Nomina').add({'Empleado': '$selectedCurrency1', 'Pago': cantidad, 'Mes': numerofecha,'Dia': int.parse(dia),'Año':2020, 'Fecha':fecha});
        
      setState(() => id = ref.documentID);
      
  }

}