import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/domain/helpers/helpers.dart';
import 'package:login_page_with_mobx/domain/entities/entities.dart';

import 'package:login_page_with_mobx/data/cache/cache.dart';
import 'package:login_page_with_mobx/data/usecases/usecases.dart';

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

void main() {

  FetchSecureCacheStorage fetchSecureCacheStorageSpy;
  LocalLoadCurrentAccount sut;
  String token;

  setUp(() {
    fetchSecureCacheStorageSpy = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorageSpy);
    token = faker.guid.guid();
  });

  test('Should call FetchSecureCacheStorage with correct values', () async {

    await sut.load();

    verify(fetchSecureCacheStorageSpy.fetch(key: 'token'));

  });
  
  test('Should return an AccountEntity if FetchSecureCacheStorage returns success', () async {

    when(fetchSecureCacheStorageSpy.fetch(key: anyNamed('key'))).thenAnswer((_) async => token);

    final account = await sut.load();

    expect(account, AccountEntity(token));

  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws', () async {
    when(fetchSecureCacheStorageSpy.fetch(key: anyNamed('key'))).thenThrow(Exception());

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

}