import 'package:flutter/material.dart';
import 'package:valenki/models/sneakers_model.dart';

import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;
  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoesSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleChechk(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneaker;
  void getMale() {
    male = Helper().getMaleSneaker();
    notifyListeners();
  }

  void getFemale() {
    female = Helper().getFemaleSneaker();
    notifyListeners();
  }

  void getKids() {
    kids = Helper().getKidsSneaker();
    notifyListeners();
  }

  void getShoes(
    String category,
    String id,
  ) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakerById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakerById(id);
    } else {
      sneaker = Helper().getKidsSneakerById(id);
    }
    notifyListeners();
  }
}
