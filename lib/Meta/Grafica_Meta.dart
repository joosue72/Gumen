import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumen/CrearProducto.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

import 'Editar_Meta.dart';


class Meta extends StatefulWidget {

  

 

   
    


  @override
  _MetaState createState() => _MetaState();
}
String t ; double total;
Timer _timer;
 double total1;

 double resultado ;
 double porcentaje = 0;
class _MetaState extends State<Meta> {
 int currentPage = DateTime.now().month - 1;
   Stream<QuerySnapshot> _query;
 
  final db = Firestore.instance;


   @override
  void initState() {
    super.initState();
    

      int currentPage = DateTime.now().month - 1;
        

              db
                .collection('Ventas')
                .where("Mes", isEqualTo: currentPage + 1) 
                .snapshots()
                .listen((result) {
                result.documents.forEach((result) { 
                  t = result.data['Costo'].toString();

                  total1 = double.parse(t);
                  
                
                  
                    resultado = resultado + double.parse(t);
                
                      
                });
          
                  print(resultado); 
                 
                    
                });
            

    setState(() {_expenses2();});
      
  }
 

    
 
 
   @override
   
   Widget build(BuildContext context) {


   

   traermeta();

 
 

 

     
    
    return Scaffold(
      
      

      appBar: AppBar(title:Text("Meta de Ventas"),),
      body: Container(
        padding:EdgeInsets.all(25.0),
        child:Column(
          children: <Widget>[
            
            _expenses(),
            CircularPercentIndicator(
              progressColor: Colors.redAccent,
              percent: porcentaje,
              animation:true,
              radius:250.0,
              lineWidth:20.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text((porcentaje * 100).toStringAsFixed(2)+ "%"),
            ),
          _expenses2(),

            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 250.0,
              lineHeight: 15.0,
              progressColor: Colors.orangeAccent,
              percent: porcentaje,
              center: Text((porcentaje * 100).toStringAsFixed(2)+ "%"),
              animation: true,
            ),
            
            

          ],
        )
      ), floatingActionButton: _crearBoton( context ),
      
    );
   }
  

  
    traermeta() async{

     

  


            

    
 
        
        
          db
          .collection("Meta")
          .snapshots()
          .listen((result) {
        result.documents.forEach((result) {
          t = result.data['Valor'].toString();
            total = double.parse(t);
            print(total);
        });
              
        });

        porcentaje = (resultado * 100 /total)/100;
        print(porcentaje);

       

     }
   
  Widget _expenses()  {
   
    return Column(
      children: <Widget>[
        
        Text("\$${total}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Meta de Ventas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }


  Widget _expenses2() {
   
    return Column(
      children: <Widget>[
        
        Text("\$${resultado}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Total de Ventas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

   _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.orange,
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => editar_meta());
         Navigator.of(context).push(route);
         },
    );
  }


 
}