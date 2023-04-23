import 'Clothes.dart';

class ClothesWardrobe {
  List<Clothes> tops;
  List<Clothes> bottoms;
  List<Clothes> outwears;
  List<Clothes> shoes;
  List<Clothes> accessories;

  ClothesWardrobe(
      {required this.tops,
      required this.bottoms,
      required this.outwears,
      required this.shoes,
      required this.accessories});

  List<Clothes>? getClothesList(int type) {
    switch (type) {
      case 0:
        return tops;
      case 1:
        return bottoms;
      case 2:
        return outwears;
      case 3:
        return shoes;
      case 4:
        return accessories;
      case 5:
        return accessories;
    }
    return null;
  }
}
