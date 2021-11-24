import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_page_with_mobx/data/cache/cache.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';


class LocalStorageAdapter implements SaveSecureCacheStorage {

  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({@required this.secureStorage});

  @override
  Future<void> saveSecure({@required String key,@required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

}

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {

  test('Should call save secure with correct values', () async {
    final storage = FlutterSecureStorageSpy();
    final sut = LocalStorageAdapter(secureStorage: storage);

    final key = faker.lorem.word();
    final value = faker.guid.guid();

    await sut.saveSecure(key: key, value: value);

    verify(storage.write(key: key, value: value));
  });
}