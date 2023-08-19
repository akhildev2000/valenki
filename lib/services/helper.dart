import 'package:flutter/services.dart' as the_bundle;
import 'package:valenki/models/sneakers_model.dart';

class Helper {
  //Males List of Data
  Future<List<Sneakers>> getMaleSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakerFromJson(data);
    return maleList;
  }

//Females List of Data
  Future<List<Sneakers>> getFemaleSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakerFromJson(data);
    return femaleList;
  }

//Kids List of Data
  Future<List<Sneakers>> getKidsSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakerFromJson(data);
    return kidsList;
  }

//Male Single Data
  Future<Sneakers> getMaleSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakerFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

//Female Single Data
  Future<Sneakers> getFemaleSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakerFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

//Kid Single Data
  Future<Sneakers> getKidsSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakerFromJson(data);
    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
