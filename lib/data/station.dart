class Station{
  String name, uri;

  Station(this.name, this.uri);

  factory Station.fromJson(Map<String, dynamic> json){
    return Station(json['name'], json['uri']);
  }
}