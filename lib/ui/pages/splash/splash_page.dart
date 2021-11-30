import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/pages/pages.dart';

class SplashPage extends StatelessWidget {

  final SplashPresenter splashPresenter;

  SplashPage({@required this.splashPresenter});

  @override
  Widget build(BuildContext context) {
    splashPresenter.loadCurrentAccount();

    return Scaffold(
      body: Builder(
        builder: (context) {
          splashPresenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
            }
          });
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      ),
    );
  }
}