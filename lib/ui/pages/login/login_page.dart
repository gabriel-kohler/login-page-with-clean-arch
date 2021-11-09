import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final screenHeight = (size.height - MediaQuery.of(context).padding.top);
    final _formKey = GlobalKey<FormState>();

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 10),
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 5),
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
                            labelText: 'Senha',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: const Color(0xFFE87653),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 30),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 348,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFE87653),
                              const Color(0xFFFD6713),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          key: ValueKey('login'),
                          onTap: null,
                          child: Center(
                            child: Text(
                              'Login',
                              style: GoogleFonts.ptSans(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              // Text('Ou entre com'),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: 25, vertical: 15),
              //       child: IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.facebook,
              //           size: 50,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: 25, vertical: 15),
              //       child: IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.facebook,
              //           size: 50,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}