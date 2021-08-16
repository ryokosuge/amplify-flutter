import 'package:amplify_flutter/service/auth/auth_credentials.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;
  final VoidCallback shouldShowSignUp;

  const LoginPage({
    Key? key,
    required this.didProvideCredentials,
    required this.shouldShowSignUp,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username:  $username');
    print('password:  $password');

    final credentials = LoginCredentials(
      username: username,
      password: password,
    );
    widget.didProvideCredentials(credentials);
  }

  Widget _loginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: 'Username',
          ),
        ),
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        //LoginButton
        TextButton(
          onPressed: _login,
          child: Text('Login'),
          style: TextButton.styleFrom(
            primary: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Stack(
          children: [
            // Login Form
            _loginForm(context),
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text('Don\'t have an account? Sign up.'),
                onPressed: widget.shouldShowSignUp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
