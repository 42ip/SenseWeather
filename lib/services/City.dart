class City {
  String name;
  int id;
  City({this.name, this.id});
  factory City.fromJson(Map<String, dynamic> json) {
    return new City(
      name: json['name'] as String,
      id: json['id'] as int,
    );
  }
}
