class Suit {
  int suitId;
  int? topId;
  int? bottomId;
  int? onePieceId;
  int? shoesId;
  int? accessoryId;

  Suit(
      {required this.suitId,
      this.topId,
      this.bottomId,
      this.onePieceId,
      this.shoesId,
      this.accessoryId});

  factory Suit.fromJson(Map<String, dynamic> json) {
    return Suit(
        suitId: json['suitId'],
        topId: json['topId'],
        bottomId: json['bottomId'],
        onePieceId: json['onePieceId'],
        shoesId: json['shoesId'],
        accessoryId: json['accessoryId']);
  }
}
