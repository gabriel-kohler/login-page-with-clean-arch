import '/ui/pages/pages.dart';
import '/presentation/presenters/presenters.dart';
import '/main/factories/factories.dart';


SplashPresenter makeSplashPresenter() {
  return GetxSplashPresenter(
    loadCurrentAccount: makeLoadCurrentAccount(),
  );
}