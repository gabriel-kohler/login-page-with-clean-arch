import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_page_with_mobx/utils/utils.dart';
//import 'package:login_page_with_mobx/utils/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  //const Color(0xFFFD6713),
  //const Color(0xFFE87653),

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 30,
                bottom: 30,
              ),
              child: Text(
                'Bem-vindo!', 
                style: GoogleFonts.sourceCodePro(
                  fontSize: 50,
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 60),
                height: 300,
                child: Image.asset('assets/img/imgwelcome.png'),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: 48,
              width: 330,
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
                key: ValueKey('signIn'),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.LOGIN_PAGE),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.ptSans(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 48,
              width: 330,
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFebebeb),
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                key: ValueKey('signUp'),
                onTap: () {},
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.ptSans(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
