
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Meta extends StatefulWidget {
    
    


  @override
  _MetaState createState() => _MetaState();
}

class _MetaState extends State<Meta> {
 int currentPage = DateTime.now().month - 1;



   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Meta de Ventas"),),
      body: Container(
        padding:EdgeInsets.all(25.0),
        child:Column(
          children: <Widget>[
            CircularPercentIndicator(
              progressColor: Colors.redAccent,
              percent:.10,
              animation:true,
              radius:250.0,
              lineWidth:20.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text("Circulo"),
            ),
          Container(
            
          ),

            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 250.0,
              lineHeight: 15.0,
              progressColor: Colors.orangeAccent,
              percent: 0.7,
              center: Text("Circulo"),
              animation: true,
            )
          ],
        )
      ),
      
    );
   }
  

  
}