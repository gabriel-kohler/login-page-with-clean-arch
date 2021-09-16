import 'package:flutter/material.dart';
import 'package:login_page_with_mobx/components/login_form.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top);
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        color: Colors.white,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.2),
              Container(
                height: screenHeight * 0.43,
                child: Image.asset('assets/img/imglogin.png'),
              ),
              Container(
                height: screenHeight * 0.37,
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
