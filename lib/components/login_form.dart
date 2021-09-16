import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: const Color(0xFFE87653),
                ),
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: const Color(0xFFE87653),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: const Color(0xFFE87653),
                ),
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: const Color(0xFFE87653),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
