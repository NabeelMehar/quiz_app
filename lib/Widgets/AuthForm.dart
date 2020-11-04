import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
      this.submitFn,
      this.isLoading,
      );

  final bool isLoading;
  final void Function(
      String email,
      String password,
      String userName,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Theme(
                  data: new ThemeData(
                    hintColor: Colors.white,
                    primaryColor: Colors.white,
                    primaryColorDark: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                ),
                if (!_isLogin)
                  SizedBox(height: 20,),

                if (!_isLogin)
                  Theme(
                    data: new ThemeData(
                      hintColor: Colors.white,
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  ),
                SizedBox(height: 20,),
                Theme(
                  data: new ThemeData(
                    hintColor: Colors.white,
                    primaryColor: Colors.white,
                    primaryColorDark: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                          color: Colors.white
                        ),
                      ),),

                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                ),
                SizedBox(height: 12),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed: _trySubmit,
                    color: Colors.purple,
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    shape:  RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
