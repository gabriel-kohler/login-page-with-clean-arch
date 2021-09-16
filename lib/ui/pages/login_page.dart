import 'package:flutter/material.dart';
import 'package:login_page_with_mobx/ui/components/login_form.dart';

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
              SizedBox(height: 80),
              Container(
                height: 320,
                child: Image.asset('assets/img/imglogin.png'),
              ),
              Container(
                height: 260,
                child: LoginForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Não tem uma conta?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Cadastre-se aqui'),
                  ),
                ],
              ),
              Text('Ou entre com'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.facebook,
                        size: 50,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.facebook,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
