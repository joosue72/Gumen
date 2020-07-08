import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gumen/Empleados.dart';
import 'package:gumen/Gastos.dart';
import 'package:gumen/Grafica_Meta.dart';
import 'package:gumen/RegistroCliente.dart';
import 'package:gumen/venta_grafica.dart';
import 'Ventas.dart';
import 'VentasPendientes.dart';
import 'Gastos.dart';
import 'Proveedores.dart';
import 'Inventario.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;
    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

             gradient: new LinearGradient(colors: [const Color(0xFFba8d13), const Color(0xFFffffff)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
                
             
             
             )
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 84,
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.yellow,
                          backgroundImage: AssetImage(
                              'assets/logogumen.png'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                       
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                              shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/carrito1.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Ventas());
                               Navigator.of(context).push(route);
                              
                             },
                            ),

                           
                          
                        ),

                        Card(
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/pendientes.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               Navigator.of(context).push(route);
                              
                             },
                            ),

                           
                          
                        ),
                        

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/nomina1.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Empleados());
                               Navigator.of(context).push(route);
                              
                             },
                             
                            ),
                            
                            
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/stat.png'), height: 100, alignment: Alignment.center, 

                            
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => venta_grafica());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/gasto.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Gastos());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
<<<<<<< HEAD
                            child: Ink.image(image: AssetImage('images/inventario.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Inventario());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/proveedor.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Proveedores());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/meta.png'), height: 100, alignment: Alignment.center, 
=======
                            child: Ink.image(image: AssetImage('images/gasto.png'), height: 100, alignment: Alignment.center, 
>>>>>>> 30f4a9b699b998a0c7107d2361f843773526b711
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Meta());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
