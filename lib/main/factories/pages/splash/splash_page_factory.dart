import '/ui/pages/pages.dart';
import '/main/factories/pages/pages.dart';

SplashPage makeSplashPage() {
  return SplashPage(
    splashPresenter: makeSplashPresenter(),
  );
}