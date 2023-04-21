import 'package:flutter/material.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'package:wardrobe/model/User.dart';
import 'package:wardrobe/model/Clothes.dart';

import 'model/Suit.dart';

// 存储全局变量的provider，现在只有存储登录后的用户信息
class StoreProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  late ClothesWardrobe _clothesWardrobe;

  ClothesWardrobe get clothesWardrobe => _clothesWardrobe;

  late List<Suit> _suitList;

  List<Suit> get suitList => _suitList;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setClothesWardrobe(ClothesWardrobe clothesWardrobe) {
    _clothesWardrobe = clothesWardrobe;
    print(_clothesWardrobe);
    notifyListeners();
  }

  void setSuitList(List<Suit> suitList) {
    _suitList = suitList;
    print(_suitList);
    notifyListeners();
  }

  List<Clothes>? getClothesList(int type) {
    switch (type) {
      case 0:
        return _clothesWardrobe.tops;
      case 1:
        return _clothesWardrobe.bottoms;
      case 2:
        return _clothesWardrobe.onePieces;
      case 3:
        return _clothesWardrobe.shoes;
      case 4:
        return _clothesWardrobe.accessories;
    }
    return null;
  }

  List<Suit> getSuitList() {
    return _suitList;
  }

  void addClothes(Clothes clothes) {
    int type = clothes.type;
    switch (type) {
      case 0:
        _clothesWardrobe.tops.add(clothes);
        break;
      case 1:
        _clothesWardrobe.bottoms.add(clothes);
        break;
      case 2:
        _clothesWardrobe.onePieces.add(clothes);
        break;
      case 3:
        _clothesWardrobe.shoes.add(clothes);
        break;
      case 4:
        _clothesWardrobe.accessories.add(clothes);
        break;
    }
    notifyListeners();
  }

  void deleteClothes(Clothes clothes) {
    int type = clothes.type;
    switch (type) {
      case 0:
        _clothesWardrobe.tops
            .removeWhere((element) => element.id == clothes.id);
        break;
      case 1:
        _clothesWardrobe.bottoms
            .removeWhere((element) => element.id == clothes.id);
        break;
      case 2:
        _clothesWardrobe.onePieces
            .removeWhere((element) => element.id == clothes.id);
        break;
      case 3:
        _clothesWardrobe.shoes
            .removeWhere((element) => element.id == clothes.id);
        break;
      case 4:
        _clothesWardrobe.accessories
            .removeWhere((element) => element.id == clothes.id);
        break;
    }
    notifyListeners();
  }
}
