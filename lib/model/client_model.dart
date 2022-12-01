import 'city_model.dart';

class ClientModel {
  int id;
  String name;
  String gender;
  int age;
  CityModel city;

  ClientModel(this.id, this.name, this.gender, this.age, this.city);

  factory ClientModel.fromJson(dynamic json) {
    return ClientModel(
        json["id"] as int,
        json["name"] as String,
        json["gender"] as String,
        json["age"] as int,
        CityModel.fromJson(json["city"]));
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'name': name,
        'gender': gender,
        'age': age,
        'city': city.toJson()
      };
}
