import 'package:flutter/material.dart';
import 'package:gumen/RegistroCliente.dart';
import 'dart:async';
import 'Login.dart';
import 'details_page.dart';




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
        },
  routes: {
    'Empleado' : (BuildContext context) => RegistroCliente(),
    
  },
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