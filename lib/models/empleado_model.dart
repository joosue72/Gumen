// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    Client({
        this.id,
        this.nombrecompleto = '',
        this.sueldo = 0.0,
        this.fotoUrl,
    });

    String id;
    String nombrecompleto;
    double sueldo;
    String fotoUrl;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        nombrecompleto: json["nombrecompleto"],
        sueldo: json["Sueldo"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
      //  "id": id,
        "nombrecompleto": nombrecompleto,
        "Sueldo": sueldo,
        "fotoUrl": fotoUrl,
    };
}
