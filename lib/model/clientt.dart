import 'city.dart';

class Clientt {
  int id;
  String name;
  String gender;
  int age;
  City city;

  Clientt(this.id, this.name, this.gender, this.age, this.city);

  factory Clientt.fromJson(dynamic json) {
    return Clientt(
        json["id"] as int,
        json["name"] as String,
        json["gender"] as String,
        json["age"] as int,
        City.fromJson(json["city"]));
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'name': name,
        'gender': gender,
        'age': age,
        'city': city.toJson()
      };
}
