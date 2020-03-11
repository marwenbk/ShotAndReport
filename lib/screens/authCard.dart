import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/httpException.dart';
import '../provider/auth.dart';
import 'login.dart';
class AuthCard extends StatefulWidget {
  static const pageRoute = '/identification';

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حصل خطأ'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const Text('حسنا'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _addresseFocusNode.dispose();
    _confPassFocusNode.dispose();
    _passFocusNode.dispose();
    _telFocusNode.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'tel': '',
    'nom': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(
      () {
        _isLoading = true;
      },
    );
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password'])
            .then((_) {
          Navigator.of(context).maybePop();
        });
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password'], _authData['tel'],
                _authData['nom'])
            .then((_) {
          Navigator.of(context).maybePop();
        });
      }
    } on HttpException catch (error) {
      var errorMessage = 'حصل خطأ';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = '.هذا البريد الالكتروني مستعمل';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = '.البريد الالكتروني خاطئ';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = '.كلمة السر سهلة';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = '.هذا المستخدم غير مسجل';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = '.كلمة المرور غير مطابقة';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = '.هنالك خلل  تعذر وصلك بالشبكة';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  final _telFocusNode = FocusNode();
  final _addresseFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _confPassFocusNode = FocusNode();
  var init = false;
  @override
  void didChangeDependencies() {
    if (!init) _authMode = ModalRoute.of(context).settings.arguments;
    setState(() {
      init = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
              title: Text(
                _authMode == AuthMode.Signup
                    ? 'أفتح حساب الأن'
                    : 'تسجيل الدخول',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            
        
      
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_telFocusNode);
                      },
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        labelText: '  الاسم واللقب',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20),
                            gapPadding: 0),
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) return 'ادخل الاسم و اللقب';
                      },
                      onSaved: (value) {
                        _authData['nom'] = value;
                      },
                    ),
                  ),
                const SizedBox(height: 10),
                if (_authMode == AuthMode.Signup)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      maxLines: 1,
                      focusNode: _telFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addresseFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.end,
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        labelText: 'الهاتف',
                        suffixText: '  216+',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.length < 7) return 'ادخل الهاتف';
                      },
                      onSaved: (value) {
                        _authData['tel'] = value;
                      },
                    ),
                  ),
                if (_authMode == AuthMode.Login)
                  Center(
                    child: Text(
                      'أهلا بك ',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                if (_authMode == AuthMode.Login)
                  SizedBox(
                    height: deviceSize.height * 0.1,
                  ),
                const SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passFocusNode);
                    },
                    focusNode: _addresseFocusNode,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: 'البريد الالكتروني',
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'البريد الالكتروني خاطا';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    onFieldSubmitted: (_) {
                      if (_authMode == AuthMode.Signup) {
                        FocusScope.of(context).requestFocus(_confPassFocusNode);
                      }
                    },
                    focusNode: _passFocusNode,
                    textInputAction: _authMode == AuthMode.Signup
                        ? TextInputAction.next
                        : TextInputAction.done,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: 'كلمة السر',
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'كلمة السر يجب ان تكون 6 حروف على الاقل';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                if (_authMode == AuthMode.Login)
                  Container(
                    margin: EdgeInsets.only(
                        right: deviceSize.width * 0.47,
                        left: deviceSize.width * 0.01),
                    child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          '* نسيت كلمة المرور؟',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        )),
                  ),
                const SizedBox(height: 10),
                if (_authMode == AuthMode.Signup)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      focusNode: _confPassFocusNode,
                      textInputAction: TextInputAction.done,
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        labelText: 'اعادة كلمة السر',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'كلمة السر ليست مطابقة';
                              }
                            }
                          : null,
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: deviceSize.height * 0.1),
                  width: deviceSize.width * 0.5,
                  height: 46,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submit,
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            _authMode == AuthMode.Login
                                ? 'تسجيل الدخول'
                                : 'أفتح حساب الأن',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
