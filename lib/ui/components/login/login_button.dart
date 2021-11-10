import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/ui/pages/login/login.dart';

class LoginButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final loginPresenter = Provider.of<LoginPresenter>(context);
    return Container(
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
      child: StreamBuilder<bool>(
          stream: loginPresenter.isFormValidStream,
          builder: (context, snapshot) {
            return InkWell(
              key: ValueKey('login'),
              onTap: snapshot.data == true
                  ? loginPresenter.auth
                  : null,
              child: Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.ptSans(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
    );
  }
}