import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: 30,
                bottom: 30,
              ),
              child: Text(
                'Welcome!',
                style: GoogleFonts.sourceCodePro(
                  fontSize: 50,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 400,
                child: Image.asset('assets/img/imgwelcome.png'),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 45,
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
                onTap: () {},
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
              height: 45,
              width: 330,
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFebebeb),
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
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
