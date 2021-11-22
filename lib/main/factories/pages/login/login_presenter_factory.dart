import '/main/factories/pages/login/login.dart';
import '/main/factories/usecases/usecases.dart';

import '/ui/pages/login/login.dart';
import '/presentation/presenters/presenters.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
  );
}
