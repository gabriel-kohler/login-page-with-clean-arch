import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:meta/meta.dart';

abstract class FetchSecureCacheStorage {
  Future<String> fetch({@required key});
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

class LocalLoadCurrentAccount {

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<void> load() async {
    await fetchSecureCacheStorage.fetch(key: 'token');
  }
}

void main() {

  test('Should call FetchSecureCacheStorage with correct values', () async {
    final fetchSecureCacheStorageSpy = FetchSecureCacheStorageSpy();
    final sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorageSpy);

    await sut.load();

    verify(fetchSecureCacheStorageSpy.fetch(key: 'token'));

  });
}