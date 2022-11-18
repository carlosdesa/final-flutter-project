class City {
  int id;
  String name;
  String uf;

  City(this.id, this.name, this.uf);

  factory City.fromJson(dynamic json) {
    return City(
        json["id"] as int, json["name"] as String, json["uf"] as String);
  }

  Map<String, dynamic> toJson() =>
      {if (id != 0) 'id': id, 'name': name, 'uf': uf};
}
