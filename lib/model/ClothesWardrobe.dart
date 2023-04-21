import 'Clothes.dart';

class ClothesWardrobe {
  List<Clothes> tops;
  List<Clothes> bottoms;
  List<Clothes> onePieces;
  List<Clothes> shoes;
  List<Clothes> accessories;

  ClothesWardrobe(
      {required this.tops,
      required this.bottoms,
      required this.onePieces,
      required this.shoes,
      required this.accessories});
}
