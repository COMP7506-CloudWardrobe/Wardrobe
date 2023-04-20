class Clothes {
  int? id;
  int? type;

  Clothes({this.id, this.type});

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['clothesId'],
      type: json['type'],
    );
  }
}
