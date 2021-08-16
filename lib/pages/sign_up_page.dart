import 'package:amplify_flutter/service/auth/auth_credentials.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  final VoidCallback shouldShowLogin;
  const SignUpPage({
    Key? key,
    required this.didProvideCredentials,
    required this.shouldShowLogin,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('username:  $username');
    print('email:     $email');
    print('password:  $password');

    final credentials = SignUpCredentials(
      username: username,
      email: email,
      password: password,
    );
    widget.didProvideCredentials(credentials);
  }

  Widget _signUpForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: 'Username',
          ),
        ),
        // Email TextField
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: 'Email',
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
        // SignUpButton
        TextButton(
          onPressed: _signUp,
          child: Text('Sign Up'),
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
            _signUpForm(context),
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text('Already have an accout? Login.'),
                onPressed: widget.shouldShowLogin,
              ),
            )
          ],
        ),
      ),
    );
  }
}
