class Station {
  int id;
  String name, uri, imageUrl, countryCode;
  bool star = false;

  Station(
      this.id, this.name, this.uri, this.imageUrl, this.star, this.countryCode);

  factory Station.fromJson(Map<String, dynamic> json) {
    var id = int.parse(json['id'].toString());
    var star = json.containsKey('star') ? parseBool(json['star']) : false;
    return Station(id, json['name'], json['uri'], json['imageUrl'], star,
        json['countryCode']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'uri': uri,
        'imageUrl': imageUrl,
        'countryCode': countryCode,
        'star': star ? 1 : 0
      };

  static bool parseBool(int value) => value == 1;
}
