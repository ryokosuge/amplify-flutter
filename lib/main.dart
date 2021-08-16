import 'package:amplify_flutter/pages/login_page.dart';
import 'package:amplify_flutter/pages/sign_up_page.dart';
import 'package:amplify_flutter/pages/verification_page.dart';
import 'package:amplify_flutter/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                if (snapshot.data?.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                    child: LoginPage(
                      didProvideCredentials: _authService.loginWithCredentials,
                      shouldShowSignUp: _authService.showSignUp,
                    ),
                  ),
                if (snapshot.data?.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                    child: SignUpPage(
                      didProvideCredentials: _authService.signUpWithCredentials,
                      shouldShowLogin: _authService.showLogin,
                    ),
                  ),
                if (snapshot.data?.authFlowStatus ==
                    AuthFlowStatus.verification)
                  MaterialPage(
                    child: VerificationPage(
                      didProvideVerificationCode: _authService.verifyCode,
                    ),
                  ),
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
