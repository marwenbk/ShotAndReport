import 'package:flutter/material.dart';
import './authCard.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const pageRoute = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Container(
                    padding:const EdgeInsets.only(top: 5, right: 24, left: 25,bottom: 10),
                    width: deviceSize.width,
                    height: deviceSize.height * 0.4,
                    child: const FittedBox(
                      child: Image(
                        image: AssetImage('asset/icons/tunis.jpg'),
                      ),
                    )),
              
             Text(
                'مع بعضنا نبنو تونس',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
              
              Container(
                margin:const EdgeInsets.only(bottom: 27, top: 10),
                width: deviceSize.width * 0.5,
                height: 46,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.pushNamed(
                      context, AuthCard.pageRoute,
                      arguments: AuthMode.Login),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: deviceSize.width * 0.5,
                height: 46,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.pushNamed(
                      context, AuthCard.pageRoute,
                      arguments: AuthMode.Signup),
                  child:const Text(
                    'انظم لنا',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
