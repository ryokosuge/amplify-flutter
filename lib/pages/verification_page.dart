import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;

  const VerificationPage({
    Key? key,
    required this.didProvideVerificationCode,
  }) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _verificationCodeController = TextEditingController();

  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();
    widget.didProvideVerificationCode(verificationCode);
  }

  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _verificationCodeController,
          decoration: InputDecoration(
            icon: Icon(Icons.confirmation_num),
            labelText: 'Verification code',
          ),
        ),
        // Verify Button
        TextButton(
          onPressed: _verify,
          child: Text('Verify'),
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
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _verificationForm(),
      ),
    );
  }
}
