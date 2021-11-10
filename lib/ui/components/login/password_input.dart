import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/pages/login/login.dart';

class PasswordInput extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final loginPresenter = Provider.of<LoginPresenter>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 28, vertical: 5),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StreamBuilder<String>(
          stream: loginPresenter.passwordErrorStream,
          builder: (context, snapshot) {
            return TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: const Color(0xFFE87653),
                ),
                labelText: 'Senha',
                errorText: snapshot.data?.isEmpty == true
                    ? null
                    : snapshot.data,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: const Color(0xFFE87653),
                  ),
                ),
              ),
              onChanged: loginPresenter.validatePassword,
            );
          }),
    );
  }
}