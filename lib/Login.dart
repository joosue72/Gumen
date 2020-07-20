import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gumen/Animation/FadeAnimation.dart';
import 'Menu.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    final db = Firestore.instance;
     String t ;
    SystemChrome.setEnabledSystemUIOverlays([]);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 228, 62, 10),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeAnimation(1.3, Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background-2.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 300,
                    width: width+10,
                    child: FadeAnimation(1.3, Container(
                      decoration: BoxDecoration(
                        
                        image: DecorationImage(
                          
                          image: AssetImage('assets/logogumen3.png')
                          
                        )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1.5, Text("Login", style: TextStyle(color: Color.fromRGBO(0, 0, 0, 100), fontWeight: FontWeight.bold, fontSize: 30),)),
                  SizedBox(height: 30,),
                  FadeAnimation(1.7, Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 100),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    child: Column(
                      children: <Widget>[
                  
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            obscureText: true,
                           controller: myController,
                            decoration: InputDecoration(
                              
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  
                  FadeAnimation(1.9, Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: RaisedButton(
                              color: Colors.black,
                             child: Text("Login", style: TextStyle(color: Colors.white),),
                             onPressed: (){

                                 

                                  db
                                          .collection("Password")
                                          .snapshots()
                                          .listen((result) {
                                        result.documents.forEach((result) {
                                          t = result.data['Password'].toString();

                                           if(myController.text == t.toString())
                                            {

                                                Route route = MaterialPageRoute(builder: (bc) => HomeScreen());
                                                Navigator.of(context).push(route);
                                              
                                            }

                                             else
                                              {
                                                
                                                      return showDialog<void>(
                                                        context: context,
                                                        barrierDismissible: false, // user must tap button!
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Contraseña Incorrecta', textAlign: TextAlign.center),
                                                            content: SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Image.asset(
                                                                      "images/wrong.gif",
                                                                      height: 125.0,
                                                                      width: 125.0,
                                                                    )
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: Text('Approve'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    
                                              }
                                          
                                           
                                        });
                                              
                                  });

                               
                             

                              
                              
                              
                             },
                      )

                    ),

                  )
                  
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
