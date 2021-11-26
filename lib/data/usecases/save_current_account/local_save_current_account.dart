import 'package:meta/meta.dart';

import '/data/cache/cache.dart';

import '/domain/entities/entities.dart';
import '/domain/helpers/helpers.dart';
import '/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {

  final SaveSecureCacheStorage saveSecureCacheStorage;
  
  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});
  
  @override
  Future<void> save({@required AccountEntity account}) async {

    try {
      saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }

  }
}