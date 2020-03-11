import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/articles.dart';
import './screens/home.dart';
import './screens/home_overview.dart';
import './screens/map.dart';
import './screens/profile.dart';
import './screens/leaders.dart';
import './provider/users.dart';
import './provider/auth.dart';
import './screens/login.dart';
import './screens/authCard.dart';
import './screens/singleArticle.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Articles(),
        ),
        ChangeNotifierProvider.value(value: Users()),
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color.fromRGBO(50, 130, 184, 1),
            accentColor: Color.fromRGBO(187, 225, 250, 1),
            fontFamily: 'Roboto',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'Roboto-Bold',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
home: auth.isAuth ? HomeOverView() : AuthScreen(),  
// home: HomeOverView(),
      routes: {
        SingleItem.pageRoute:(ctx)=>SingleItem(),
        AuthCard.pageRoute:(ctx)=>AuthCard(),
          HomeOverView.pageRoute: (ctx) => HomeOverView(),
          Home.pageRoute: (ctx) => Home(),
          MapScreen.pageRoute: (ctx) => MapScreen(),
          Profile.pageRoute: (ctx) => Profile(),
          Leaders.pageRoute: (ctx) => Leaders(),
          AuthScreen.pageRoute:(ctx)=>AuthScreen(),
        },
      ),)
    );
  }
}
