import 'package:flutter/material.dart';
import 'package:gumen/Grafica_Nominas/details_page_gastos.dart';
import 'dart:async';
import 'Grafica_Gastos/details_page_gastos.dart';
import 'Grafica_Ventas/details_page.dart';
import 'Login.dart';





void main() {
  runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
  onGenerateRoute: (settings) {
         if(settings.name == '/details'){
           DetailsPage params = settings.arguments;
           return MaterialPageRoute(builder: (BuildContext context){
             return DetailsParams(params: params,);});
         }

         if(settings.name == '/details2'){
           DetailsPage2 params = settings.arguments;
           return MaterialPageRoute(builder: (BuildContext context){
             return DetailsParams2(params: params,);});
         }

         if(settings.name == '/details3'){
           DetailsPage3 params = settings.arguments;
           return MaterialPageRoute(builder: (BuildContext context){
             return DetailsParams3(params: params,);});
         }
        }
));
}

int n1;

class MyApp  extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    super.initState();
    Future.delayed(
      
    Duration(seconds: 3),
    (){
      Navigator.push(
        context,
        MaterialPageRoute(
          
          builder: (context) => Login(),
        ),
      );
    },
  );
}

 


@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
       decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/12.gif"),
            fit: BoxFit.cover,
          ),
        ),  
      
      ),
        
    );
  }
}