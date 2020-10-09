class Station{
  String name, uri, imageUrl;

  Station(this.name, this.uri, this.imageUrl);

  factory Station.fromJson(Map<String, dynamic> json){
    return Station(json['name'], json['uri'], json['imageUrl']);
  }
}