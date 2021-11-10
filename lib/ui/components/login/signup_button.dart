import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Não tem uma conta?'),
          TextButton(
            onPressed: null,
            child: Text('Cadastre-se aqui'),
          ),
        ],
      ),
    );
  }
}