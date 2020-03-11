import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
enum Cat {
  Road,
  Light,
  Water,
  PhoneNetwork,
  PublicPropriety,
  CorruptionAdministrative,
  VenteConditionnelle,
  Contrebande,
  Monopole,
  Corruption,
  DroitsHumains,
  DroitsAnimaux
}
Map<Cat, Object> get _icons {
  return {
    Cat.Light: Image(image: AssetImage('asset/icons/electricity.png')),
    Cat.Water: Image(image: AssetImage('asset/icons/water.png')),
    Cat.Corruption: Image(image: AssetImage('asset/icons/corruption.png')),
    Cat.CorruptionAdministrative:
        Image(image: AssetImage('asset/icons/badbos.png')),
    Cat.DroitsHumains: Image(image: AssetImage('asset/icons/humanRight.png')),
    Cat.Road: Image(image: AssetImage('asset/icons/route.png')),
    Cat.DroitsAnimaux: Image(image: AssetImage('asset/icons/animalrights.png')),
    Cat.VenteConditionnelle:
        Image(image: AssetImage('asset/icons/conditionalSelling.png')),
    Cat.PhoneNetwork: Image(image: AssetImage('asset/icons/phone.png')),
    Cat.PublicPropriety: Image(image: AssetImage('asset/icons/public.png')),
    Cat.Contrebande: Image(image: AssetImage('asset/icons/contrebution.png')),
    Cat.Monopole: Image(image: AssetImage('asset/icons/monopol.png')),
  };
}

Map<Cat, String> get _url {
  return {
    Cat.Light: 'asset/icons/electricity.png',
    Cat.Water: 'asset/icons/water.png',
    Cat.Corruption: 'asset/icons/corruption.png',
    Cat.CorruptionAdministrative: 'asset/icons/badbos.png',
    Cat.DroitsHumains: 'asset/icons/humanRight.png',
    Cat.Road: 'asset/icons/route.png',
    Cat.DroitsAnimaux: 'asset/icons/animalrights.png',
    Cat.VenteConditionnelle: 'asset/icons/conditionalSelling.png',
    Cat.PhoneNetwork: 'asset/icons/phone.png',
    Cat.PublicPropriety: 'asset/icons/public.png',
    Cat.Contrebande: 'asset/icons/contrebution.png',
    Cat.Monopole: 'asset/icons/monopol.png',
  };
}

class Article with ChangeNotifier {
  @required
  String nom;
  @required
  File image;
  @required

  String description;
  @required
  LatLng poi;
  @required
  Cat category;
  @required
  int votes;
  @required
  String adress;
  int vote=0;
  Article(
      {this.adress,
      this.category,
      this.description,
      this.nom,
      this.poi,
      this.votes,
      this.image});
  Widget get icon {
    return Container(height: 30, width: 30, child: _icons[category]);
  }

  String get url {
    return _url[category];
  }

  void toggeladd() {
    votes++;
    vote+=1;
    notifyListeners();
  }

  void del() {
    votes--;
    vote-=1;
    notifyListeners();
  }
}
