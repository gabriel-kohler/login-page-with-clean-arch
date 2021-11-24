import '/main/factories/pages/login/login.dart';
import '/main/factories/usecases/usecases.dart';

import '/ui/pages/login/login.dart';
import '/presentation/presenters/presenters.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
  );
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
  );
}