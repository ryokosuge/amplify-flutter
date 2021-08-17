import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_flutter_example/service/auth/auth_credentials.dart';

enum AuthFlowStatus { login, signUp, verification, session }

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({required this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();
  AuthCredentials? _credentials;

  void checkAuthStatus() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
      } else {
        final state = AuthState(authFlowStatus: AuthFlowStatus.login);
        authStateController.add(state);
      }
    } catch (e) {
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: credentials.username,
        password: credentials.password,
      );

      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
      } else {
        print('Use could not be signed in.');
      }
    } catch (e) {
      print('Could not login - $e');
    }
  }

  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {'email': credentials.email};
      final result = await Amplify.Auth.signUp(
        username: credentials.username,
        password: credentials.password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      } else {
        this._credentials = credentials;
        final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
        authStateController.add(state);
      }
    } catch (e) {
      print('Failed to sign up - ${e.toString()}');
    }
  }

  void verifyCode(String verificationCode) async {
    final credentials = this._credentials;
    if (credentials == null) {
      return;
    }

    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: credentials.username,
        confirmationCode: verificationCode,
      );

      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      } else {
        // Follow more steps
      }
    } catch (e) {
      print('Could not verify code - $e');
    }
  }

  void logOut() async {
    try {
      await Amplify.Auth.signOut();
      showLogin();
    } catch (e) {
      print('Could not log out - $e');
    }
  }
}
