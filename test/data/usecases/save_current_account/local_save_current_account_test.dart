import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/data/usecases/usecases.dart';
import 'package:login_page_with_mobx/data/cache/cache.dart';

import 'package:login_page_with_mobx/domain/helpers/helpers.dart';
import 'package:login_page_with_mobx/domain/entities/entities.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

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

  test('Should throw UnexpectedError if SaveSecureCurrentAccount throws', () async {
    when(saveSecureCacheStorageSpy.saveSecure(key: anyNamed('key'), value: anyNamed('value'))).thenThrow(Exception());

    final future = sut.save(account: account);

    expect(future, throwsA(DomainError.unexpected));
  });

}