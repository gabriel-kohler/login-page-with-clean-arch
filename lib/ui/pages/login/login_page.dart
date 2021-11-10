import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/pages/login/login.dart';
import '/ui/components/login/login.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter loginPresenter;

  LoginPage(this.loginPresenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.loginPresenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = (size.height - MediaQuery.of(context).padding.top);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      //appBar: AppBar(),
      body: Builder(
        builder: (context) {
          widget.loginPresenter.isLoadingStream.listen(
            (isLoading) {
              if (isLoading) {
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.of(context).pop();
              }
            },
          );
          widget.loginPresenter.mainErrorStream.listen(
            (mainError) {
              if (mainError.isNotEmpty)
                return ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[900],
                    content: Text('login error'),
                  ),
                );
            },
          );
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                LoginHeader(),
                Container(
                  height: 260,
                  child: Provider(
                    create: (_) => widget.loginPresenter,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          EmailInput(),
                          PasswordInput(),
                          ForgotPasswordButton(),
                          LoginButton(),
                        ],
                      ),
                    ),
                  ),
                ),
                SignUpButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
