import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:sample_amplify/screen/screen_blogs.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _RegisterUserForm(),
    );
  }
}

class _RegisterUserForm extends StatefulWidget {
  _RegisterUserForm({Key key}) : super(key: key);

  @override
  __RegisterUserFormState createState() => __RegisterUserFormState();
}

class __RegisterUserFormState extends State<_RegisterUserForm> {
  TextEditingController _passwordController;
  TextEditingController _emailController;

  TextEditingController _passwordSignInController;
  TextEditingController _emailSignInController;
  TextEditingController _codeController;

  String _email = '';
  String _password = '';
  String _code = '';

  @override
  void initState() {
    _passwordController = TextEditingController();
    _emailController = TextEditingController();

    _passwordSignInController = TextEditingController();

    _emailSignInController = TextEditingController();

    _codeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ).copyWith(
            top: 50,
          ),
          child: Column(
            children: [
              Text('Registrate'),
              TextField(
                controller: _emailController,
                onChanged: (email) {
                  _email = email;
                  setState(() {});
                },
              ),
              TextField(
                controller: _passwordController,
                onChanged: (password) {
                  _password = password;
                  setState(() {});
                },
              ),
              RaisedButton(
                child: Center(
                  child: Text('Enviar'),
                ),
                onPressed: () => register(
                  _email,
                  _password,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Ingresa tu codigo de validacion'),
              TextField(
                controller: _codeController,
                onChanged: (code) {
                  _code = code;
                  setState(() {});
                },
              ),
              RaisedButton(
                child: Text('Validar Codigo'),
                onPressed: () => verifyCode(_email, _code),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Inicia Sesion'),
              TextField(
                controller: _emailSignInController,
                onChanged: (email) {
                  _email = email;
                  setState(() {});
                },
              ),
              TextField(
                controller: _passwordSignInController,
                onChanged: (password) {
                  _password = password;
                  setState(() {});
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text('Inicia Sesion'),
                    onPressed: () => singIn(_email, _password),
                  ),
                  RaisedButton(
                    child: Text('Salir'),
                    onPressed: () => logOut(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logOut() async {
    await Amplify.Auth.signOut();
  }

  void register(String userName, String password) async {
    try {
      final reuslt = await Amplify.Auth.signUp(
        username: userName.split('@')[0],
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: {
            'email': _email,
          },
        ),
      );

      if (reuslt.isSignUpComplete) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Registro Completado'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void verifyCode(String userName, String code) async {
    try {
      final reuslt = await Amplify.Auth.confirmSignUp(
        username: userName.split('@')[0],
        confirmationCode: code,
      );

      if (reuslt.isSignUpComplete) {
        _codeController.clear();
        _emailController.clear();
        _passwordController.clear();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Se verifico con exito'),
          ),
        );

        _email = '';
        _password = '';
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  void singIn(String userName, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: userName,
        password: password,
      );
      if (result.isSignedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ScreenBlog(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
