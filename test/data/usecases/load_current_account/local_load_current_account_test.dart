import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:login_page_with_mobx/domain/usecases/load_current_account.dart';
import 'package:login_page_with_mobx/domain/entities/entities.dart';

abstract class FetchSecureCacheStorage {
  Future<String> fetch({@required key});
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

class LocalLoadCurrentAccount implements LoadCurrentAccount {

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetch(key: 'token');
    return AccountEntity(token);
  }
}

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

}