import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/pages/login/login.dart';

class EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginPresenter = Provider.of<LoginPresenter>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 28, vertical: 10),
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StreamBuilder<String>(
          stream: loginPresenter.emailErrorStream,
          builder: (context, snapshot) {
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: const Color(0xFFE87653),
                ),
                labelText: 'Email',
                errorText:
                    snapshot.data?.isEmpty == true
                        ? null
                        : snapshot.data,
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: const Color(0xFFE87653),
                  ),
                ),
              ),
              onChanged: loginPresenter.validateEmail,
            );
          }),
    );
  }
}
