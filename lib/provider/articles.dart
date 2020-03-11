import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import './article.dart';

class Articles with ChangeNotifier {
  List<Article> _articles = [
    // Article(
    //     adress: 'elmey Djerba , rue ajim',
    //     category: Cat.Road,
    //     description: '7ofra kbira fil kayas depuis 3 ans',
    //     nom: 'trou dans la rue',
    //     poi: LatLng(33.800773, 10.882421),
    //     votes: 20),
    // Article(
    //     adress: 'isim Gabes',
    //     category: Cat.CorruptionAdministrative,
    //     description:
    //         '7absona lila kamla fel biblio minghir jrari wla mkhaded!!',
    //     nom: 'x-days problem',
    //     poi: LatLng(33.847427, 10.094467),
    //     votes: 20),
    // Article(
    //     adress: 'Route de Menzel Chaker km 6, Sfax 3000',
    //     category: Cat.DroitsAnimaux,
    //     description: 'ranche xxx mkhalya 4 7sonna blech makla pour 3 jour',
    //     nom: 'cheval a fain',
    //     poi: LatLng(34.749160, 10.662013),
    //     votes: 21),
    // Article(
    //     adress: 'مركز الشرطة بالعطار',
    //     category: Cat.Corruption,
    //     description:
    //         'jit bech ntalla3 CIN 3atlet barcha yakhi 9alli kan t7ab ta7dherlek fisa3 machi 10dt',
    //     nom: 'taleb rachwa',
    //     poi: LatLng(36.767124, 10.111862),
    //     votes: 100),
  ];
void addArticle(adress, category, description, nom, poi,photo) {
    _articles.add(Article(
        adress: adress,
        category: category,
        description: description,
        nom: nom,
        poi: poi,
        image: photo,
        votes: 0));
        notifyListeners();
  }
  Future<void> fetchAndSetPlaces() async {
    final _url='https://tunisie-4ad5f.firebaseio.com/';
    final dataList =http.get(_url);

    notifyListeners();
  }
  List<Article> get articles {
    Article x;
    for (int i = 0; i < _articles.length - 1; i++) {
      if (_articles[i].votes < _articles[i + 1].votes) {
        x = _articles[i];
        _articles[i] = _articles[i + 1];
        _articles[i + 1] = x;
      }
    }
    return [..._articles];
    
  }

  
}
