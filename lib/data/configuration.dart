class Configuration {
  int id;
  String name, value;

  Configuration(this.id, this.name, this.value);

  factory Configuration.fromJson(Map<String, dynamic> json) {
    var id = int.parse(json['id'].toString());
    return Configuration(id, json['name'], json['value']);
  }
}
