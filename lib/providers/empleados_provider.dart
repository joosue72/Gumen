import 'dart:convert';
import 'dart:io';
import 'package:gumen/models/empleado_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ClientesProvider{

  final String _url = 'https://gumen-48803.firebaseio.com/';

  Future<bool> crearProducto( Client cliente ) async {
    
    final url = '$_url/Nomina.json';

    final resp = await http.post( url, body: clientToJson(cliente) );

    final decodedData = json.decode(resp.body);

  

    print( decodedData );

    return true;

  }

  Future<List<Client>> cargarProductos() async {
    final url ='$_url/Nomina.json';
    final resp = await http.get(url);
      final List<Client> empleados = new List();
    final Map<String, dynamic> decodedData = json.decode(resp.body);


    if(decodedData == null) return [];

    decodedData.forEach((id, prod){

        final prodTemp = new Client.fromJson(prod);
        prodTemp.id = id;
          empleados.add(prodTemp);

    });

    print(empleados);
    return empleados;
  }


  Future <int> borrarEmpleado(String id) async{
    final url  ='$_url/Nomina/$id.json';
    final resp = await http.delete(url);
    return 1;
  }

  Future<bool> editarProducto( Client cliente ) async {
    
    final url = '$_url/Nomina/${cliente.id}.json';

    final resp = await http.put( url, body: clientToJson(cliente) );

    final decodedData = json.decode(resp.body);

  

    print( decodedData );

    return true;

  }


  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/ddppmiabv/image/upload?upload_preset=hzhpq1nh');
    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath('file', imagen.path, contentType: MediaType(mimeType[0],mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201 ){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);

    return respData['secure_url'];
    
  }


}