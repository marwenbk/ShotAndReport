import 'package:flutter/cupertino.dart';
class User {
  final String name;
  final int score;
  final String city;
  final ImageProvider photo;
  User({this.city, this.name, this.score, this.photo});
}
class Me{
  static String name;
  static String phone;
  static int age;
  static int score;
}
class Users with ChangeNotifier {
  List<User> _users = [
    User(
        city: 'El mey',
        score: 99,
        name: 'marwen',
        photo: AssetImage('asset/icons/marwen.jpg'),
        ),
    User(
        city: 'Jaabira',
        name: 'Mohammed',
        score: 75,
        photo: AssetImage('asset/icons/mohamed.jpg'),
        ),
    User(
        city: 'Nabel',
        name: 'Gadour',
        score: 23,
        photo:AssetImage('asset/icons/gadour.jpg'), ),
  ];
List<User>get users{
  return [..._users];
}
}
