import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 30),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Esqueceu sua senha?',
          style: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}