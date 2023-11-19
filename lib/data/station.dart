class Station {
  int id;
  String name, uri, imageUrl, countryCode;
  bool star = false;

  Station(
      this.id, this.name, this.uri, this.imageUrl, this.star, this.countryCode);

  factory Station.fromJson(Map<dynamic, dynamic> json) {
    var id = int.parse(json['id'].toString());
    var star = json.containsKey('star') ? parseBool(json['star']) : false;
    return Station(id, json['name'], json['uri'], json['imageUrl'], star,
        json['countryCode']);
  }

  factory Station.fromSupabase(Map<dynamic, dynamic> row){
    var id = int.parse(row['Id'].toString());
    var star = row.containsKey('Star') ? parseBool(row['Star']) : false;
    return Station(id, row['Name'] ?? '', row['Uri'] ?? '', row['ImageUrl'] ?? '', star,
        row['CountryCode'] ?? '');
  }

  static bool parseBool(int value) => value == 1;
}
