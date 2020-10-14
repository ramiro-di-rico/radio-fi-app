class Station{
  String name, uri, imageUrl;
  bool star = false;

  Station(this.name, this.uri, this.imageUrl);

  factory Station.fromJson(Map<String, dynamic> json){
    return Station(json['name'], json['uri'], json['imageUrl']);
  }
}