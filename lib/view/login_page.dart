import 'package:flutter/material.dart';
import 'package:login_page_with_mobx/components/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final screenHeight = (size.height - MediaQuery.of(context).padding.top);
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              Container(
                height: 350,
                child: Image.asset('assets/img/imglogin.png'),
              ),
              Container(
                height: 250,
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
