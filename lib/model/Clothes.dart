class Clothes {
  int id;
  int type;

  Clothes({required this.id, required this.type});

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['clothesId'],
      type: json['type'],
    );
  }
}
