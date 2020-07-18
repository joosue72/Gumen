import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gumen/models/empleado_model.dart';
import 'package:gumen/providers/empleados_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gumen/utils/utils.dart' as utils;

class RegistroCliente extends StatefulWidget {
  RegistroCliente({Key key}) : super(key: key);

  @override
  _RegistroClienteState createState() => _RegistroClienteState();
}

class _RegistroClienteState extends State<RegistroCliente> {
  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();
  final clienteProvider = new ClientesProvider();

  Client cliente = new Client();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
     
final Client prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      cliente = prodData;
    }
     
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        title: Text('Registro Cliente'),
         backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),

          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
          
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child:Form(
            key: formKey,
            child:Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearNomina(),
                _crearBoton()
              ],
            ),
          ),
          
        ),
      ),
    
    );
   
    }

      Widget _crearNombre(){
                return TextFormField(
                  initialValue: cliente.nombrecompleto,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Nombre Completo'
                  ),
                  onSaved: (value) => cliente.nombrecompleto = value,
                        validator: (value){
                          if(value.length < 3)
                          {
                            return 'El campo no puede estar vacio';
                          }
                          else{
                            return null;
                          }
                      },
                );
              
              }

              Widget _crearNomina(){
                return TextFormField(
                  
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Nomina',
                    hintText: '0.0'
                  ),
                  onSaved: (value) => cliente.sueldo = double.parse(value),
                  validator: (value){
                          if(utils.isNumeric(value))
                          {
                            return null;
                          }
                          else{
                            return 'Solo Números';
                          }
                      },
                );
              }

              Widget _crearBoton(){
                return RaisedButton.icon(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.orangeAccent,
                  textColor: Colors.black,
                  label: Text('Guardar'),
                  icon: Icon(Icons.save),
                  onPressed: (_guardando) ? null: _submit,
                );
              }

            void _submit() async{



              if(!formKey.currentState.validate()) return;

              formKey.currentState.save();
            
              setState(() {
                _guardando = true;   
              });

              if(foto != null){
              cliente.fotoUrl = await clienteProvider.subirImagen(foto);
              }
              if(cliente.id == null){
                clienteProvider.crearProducto(cliente);
                mostrarSnackBar('Registro Guardado');
                  Navigator.pop(context);
                
              }
              else{
                clienteProvider.editarProducto(cliente);
                mostrarSnackBar('Registro Actualizado');
                
              }


            
          

            }


            void mostrarSnackBar(String mensaje){
              final snackbar = SnackBar(
                content: Text(mensaje),
                duration: Duration(milliseconds: 1500),
              );

              scaffolKey.currentState.showSnackBar(snackbar);

            }


          Widget _mostrarFoto(){
              if(cliente.fotoUrl != null){
                //TODO: foto
                return FadeInImage(
                  image: NetworkImage(cliente.fotoUrl),
                  placeholder: AssetImage('images/original.gif'),
                  height: 300.0,
                  fit: BoxFit.contain,
                );
              }
              
              else{ 


              return Image(
                  image: AssetImage(foto?.path ??'images/no-image.png'),
                  height: 300.0,
                  fit: BoxFit.cover,
                );
              }

              
            }
        
            _seleccionarFoto() async{
            
            _procesarImagen( ImageSource.gallery );

            }

            _tomarFoto() async{
                _procesarImagen(ImageSource.camera);

            }

            _procesarImagen( ImageSource origen ) async {

            foto = await ImagePicker.pickImage(
              source: origen
            );

            if ( foto != null ) {
              cliente.fotoUrl = null;
            }

            setState(() {});

  }
}