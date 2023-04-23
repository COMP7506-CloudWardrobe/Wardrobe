class Suit {
  int suitId;
  int? topId;
  int? bottomId;
  int? outwearId;
  int? shoesId;
  int? accessoryId1;
  int? accessoryId2;

  Suit(
      {required this.suitId,
      this.topId,
      this.bottomId,
      this.outwearId,
      this.shoesId,
      this.accessoryId1,
      this.accessoryId2});

  factory Suit.fromJson(Map<String, dynamic> json) {
    return Suit(
        suitId: json['suitId'],
        topId: json['topId'],
        bottomId: json['bottomId'],
        outwearId: json['outwearId'],
        shoesId: json['shoesId'],
        accessoryId1: json['accessoryId1'],
        accessoryId2: json['accessoryId2']);
  }
}
