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

  FetchSecureCacheStorage fetchSecureCacheStorageSpy;
  LocalLoadCurrentAccount sut;

  setUp(() {
    fetchSecureCacheStorageSpy = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorageSpy);
  });

  test('Should call FetchSecureCacheStorage with correct values', () async {

    await sut.load();

    verify(fetchSecureCacheStorageSpy.fetch(key: 'token'));

  });

}