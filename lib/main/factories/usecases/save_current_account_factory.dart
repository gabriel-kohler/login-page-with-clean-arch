import 'package:login_page_with_mobx/data/usecases/usecases.dart';

import '/main/factories/factories.dart';

import '/domain/usecases/usecases.dart';

SaveCurrentAccount makeSaveCurrentAccount() {
  return LocalSaveCurrentAccount(saveSecureCacheStorage: makeSecureCacheStorage());
}