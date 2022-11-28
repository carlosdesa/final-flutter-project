import 'dart:convert';
import 'dart:io';
import 'package:fullstack/model/city.dart';
import 'package:fullstack/model/clientt.dart';
import 'package:http/http.dart';

class AccessApi {
  Future<List<Clientt>> listClients() async {
    String url = "http://192.168.0.106:8080/clientes";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<Clientt> clients =
        List<Clientt>.from(i.map((c) => Clientt.fromJson(c)));
    return clients;
  }

  Future<List<City>> listCities() async {
    String url = "http://192.168.0.106:8080/cidade";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<City> cities = List<City>.from(i.map((c) => City.fromJson(c)));
    return cities;
  }

  Future<List<City>> listCitiesByUf(String uf) async {
    String url = "http://192.168.0.106:8080/cidade/busca-uf/$uf";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<City> cities = List<City>.from(i.map((c) => City.fromJson(c)));
    return cities;
  }

  Future<List<Clientt>> listClientsByCity(String city) async {
    String url = "http://192.168.0.106:8080/clientes/busca-por-cidade/$city";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<Clientt> clients =
        List<Clientt>.from(i.map((c) => Clientt.fromJson(c)));
    return clients;
  }

  Future<void> insertClient(Map<String, dynamic> client) async {
    String url = "http://192.168.0.106:8080/clientes";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(client));
  }

  Future<void> editClient(Map<String, dynamic> client, String id) async {
    String url = "http://192.168.0.106:8080/clientes?id=$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(client));
  }

  Future<void> deleteClient(String id) async {
    String url = "http://192.168.0.106:8080/clientes/$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await delete(Uri.parse(url), headers: headers);
  }

  Future<void> insertCity(Map<String, dynamic> city) async {
    String url = "http://192.168.0.106:8080/cidade";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(city));
  }

  Future<void> editCity(Map<String, dynamic> city, String id) async {
    String url = "http://192.168.0.106:8080/cidade?id=$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(city));
  }

  Future<String> deleteCity(String id) async {
    String url = "http://192.168.0.106:8080/cidade/$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    try {
      final response = await delete(Uri.parse(url), headers: headers);
      if (response.statusCode != 200)
        throw HttpException('${response.statusCode}');
    } on HttpException catch (e) {
      if (e.toString().contains('500')) {
        return 'Esta cidade é usada por clientes registrados!';
      }
    }
    return '';
  }
}
