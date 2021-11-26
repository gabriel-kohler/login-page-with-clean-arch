import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/pages/login/login.dart';
import '/ui/components/login/login.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter loginPresenter;

  LoginPage(this.loginPresenter);


  @override
  Widget build(BuildContext context) {

    void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
    }

    final _formKey = GlobalKey<FormState>();
    
    return Scaffold(
      body: Builder(
        builder: (context) {
          loginPresenter.isLoadingStream.listen(
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
          loginPresenter.mainErrorStream.listen(
            (mainError) {
              if (mainError != null)
                return ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[900],
                    content: Text(mainError),
                  ),
                );
            },
          );
          return GestureDetector(
            onTap: _hideKeyboard,
            child: LayoutBuilder(
              builder: (_, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Container(
                      height: constraints.maxHeight * 0.5,
                      child: LoginHeader(),
                    ),
                    Container(
                      height: constraints.maxHeight * 0.4,
                      child: Provider(
                        create: (_) => loginPresenter,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                EmailInput(),
                                PasswordInput(),
                                ForgotPasswordButton(),
                                LoginButton(),
                                SizedBox(height: constraints.maxHeight * 0.02),
                                SignUpButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
