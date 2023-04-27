import 'package:flutter/material.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'package:wardrobe/model/User.dart';
import 'package:wardrobe/model/Clothes.dart';

import 'model/Share.dart';
import 'model/Suit.dart';

// 存储全局变量的provider，现在只有存储登录后的用户信息
class StoreProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  late ClothesWardrobe _clothesWardrobe;

  ClothesWardrobe get clothesWardrobe => _clothesWardrobe;

  late List<Suit> _suitList;

  List<Suit> get suitList => _suitList;

  late List<Share> _allShares;

  List<Share> get allShares => _allShares;

  late List<Share> _allMyShares;

  List<Share> get allMyShares => _allMyShares;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setClothesWardrobe(ClothesWardrobe clothesWardrobe) async {
    _clothesWardrobe = clothesWardrobe;
    print(_clothesWardrobe);
    notifyListeners();
  }

  void setSuitList(List<Suit> suitList) {
    _suitList = suitList;
    print(_suitList);
    notifyListeners();
  }

  void setAllShares(List<Share> shareList) {
    _allShares = shareList;
    print(_allShares);
    notifyListeners();
  }

  void setAllMyShares(List<Share> shareList) {
    _allMyShares = shareList;
    print(_allMyShares);
    notifyListeners();
  }

  List<Clothes>? getClothesList(int type) {
    switch (type) {
      case 0:
        return _clothesWardrobe.tops;
      case 1:
        return _clothesWardrobe.bottoms;
      case 2:
        return _clothesWardrobe.outwears;
      case 3:
        return _clothesWardrobe.shoes;
      case 4:
        return _clothesWardrobe.accessories;
      case 5:
        return _clothesWardrobe.accessories;
    }
    return null;
  }

  void addClothes(Clothes clothes) {
    int type = clothes.type;
    switch (type) {
      case 0:
        _clothesWardrobe.tops.insert(0, clothes);
        break;
      case 1:
        _clothesWardrobe.bottoms.insert(0, clothes);
        break;
      case 2:
        _clothesWardrobe.outwears.insert(0, clothes);
        break;
      case 3:
        _clothesWardrobe.shoes.insert(0, clothes);
        break;
      case 4:
        _clothesWardrobe.accessories.insert(0, clothes);
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
        _clothesWardrobe.outwears
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

  List<Suit> getSuitList() {
    return _suitList;
  }

  List<Share> getShareList() {
    // notifyListeners();
    return _allShares;
  }

  List<Share> getMyShareList() {
    // notifyListeners();
    return _allMyShares;
  }

  void deleteSuit(Suit suit) {
    _suitList.removeWhere((element) => element.suitId == suit.suitId);
    notifyListeners();
  }

  void addSuit(Suit suit) {
    _suitList.insert(0, suit);
    notifyListeners();
  }

  void addShare(Share share) {
    _allShares.insert(0, share);
    _allMyShares.insert(0, share);
    notifyListeners();
  }
}
