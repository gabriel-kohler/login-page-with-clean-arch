import '/main/factories/pages/login/login.dart';

import '/ui/pages/pages.dart';

LoginPage makeLoginPage() {
  return LoginPage(
    makeLoginPresenter(),
  );
}
