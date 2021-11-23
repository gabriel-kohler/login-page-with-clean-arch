import 'package:faker/faker.dart';
import 'package:login_page_with_mobx/domain/helpers/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:login_page_with_mobx/domain/entities/entities.dart';
import 'package:login_page_with_mobx/domain/usecases/usecases.dart';

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

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


void main() {

  LocalSaveCurrentAccount sut;
  AccountEntity account;
  SaveSecureCacheStorage saveSecureCacheStorageSpy;

  setUp(() {
    saveSecureCacheStorageSpy = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorageSpy);
    account = AccountEntity(faker.guid.guid());
  });

  test('Should call SaveCurrentAccount with correct values', () async {

    await sut.save(account: account);
    
    verify(saveSecureCacheStorageSpy.saveSecure(key: 'token', value: account.token));

  });

}