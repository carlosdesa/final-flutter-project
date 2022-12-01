import 'dart:convert';
import 'dart:io';
import 'package:fullstack/model/city_model.dart';
import 'package:fullstack/model/client_model.dart';
import 'package:http/http.dart';

class AccessApi {
  Future<List<ClientModel>> listClients() async {
    String url = "http://localhost:8080/clientes";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<ClientModel> clients =
        List<ClientModel>.from(i.map((c) => ClientModel.fromJson(c)));
    return clients;
  }

  Future<List<CityModel>> listCities() async {
    String url = "http://localhost:8080/cidade";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<CityModel> cities = List<CityModel>.from(i.map((c) => CityModel.fromJson(c)));
    return cities;
  }

  Future<List<CityModel>> listCitiesByUf(String uf) async {
    String url = "http://localhost:8080/cidade/busca-uf/$uf";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<CityModel> cities = List<CityModel>.from(i.map((c) => CityModel.fromJson(c)));
    return cities;
  }

  Future<List<ClientModel>> listClientsByCity(String city) async {
    String url = "http://localhost:8080/clientes/busca-por-cidade/$city";
    Response response = await get(Uri.parse(url));
    String formattedJsonUtf8 = (utf8.decode(response.bodyBytes));
    Iterable i = json.decode(formattedJsonUtf8);
    List<ClientModel> clients =
        List<ClientModel>.from(i.map((c) => ClientModel.fromJson(c)));
    return clients;
  }

  Future<void> insertClient(Map<String, dynamic> client) async {
    String url = "http://localhost:8080/clientes";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(client));
  }

  Future<void> editClient(Map<String, dynamic> client, String id) async {
    String url = "http://localhost:8080/clientes?id=$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(client));
  }

  Future<void> deleteClient(String id) async {
    String url = "http://localhost:8080/clientes/$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await delete(Uri.parse(url), headers: headers);
  }

  Future<void> insertCity(Map<String, dynamic> city) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(city));
  }

  Future<void> editCity(Map<String, dynamic> city, String id) async {
    String url = "http://localhost:8080/cidade?id=$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(city));
  }

  Future<String> deleteCity(String id) async {
    String url = "http://localhost:8080/cidade/$id";
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
