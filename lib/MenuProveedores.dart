
import 'package:flutter/material.dart';
import 'DetallesProveedores.dart';
import 'package:gumen/NombresProveedores.dart';
import 'package:gumen/Proveedores.dart';



 class MenuProveedor extends StatefulWidget {
  MenuProveedor({Key key}) : super(key: key);

  @override
  _MenuProveedorState createState() => _MenuProveedorState();
}

bool _debugLocked = false;

class _MenuProveedorState extends State<MenuProveedor> {
  @override
  Widget build(BuildContext context) {
    assert(!_debugLocked);
    
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

             gradient: new LinearGradient(colors: [const Color(0xFFFFC107), const Color(0xFFFFE57F)],
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
                          backgroundColor: Color(0xFFFFC107),
                          backgroundImage: AssetImage(
                              'assets/logogumen3.png'),    
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
                            color: Color(0xFFF57F17),
                            
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
                            color: Color(0xFF00BCD4),
                            
                            child: Ink.image(image: AssetImage('images/proveedor2.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => NombresProveedores());
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
                            color: Color(0xFFFFC107),
                            
                            child: Ink.image(image: AssetImage('images/proveedor3.png'), height: 100, alignment: Alignment.center, 

                            
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => DetallesProveedores());
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

class CircularButton extends StatelessWidget {
 final double width;
 final double height;
 final Color color;
 final Icon icon;
 final Function onClick;

  const CircularButton({Key key, this.width, this.height, this.color, this.icon, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true, onPressed: onClick),
      
    );
  }
}