import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/infra/cache/cache.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {

  FlutterSecureStorage storage;
  LocalStorageAdapter sut;
  String key;
  String value;

  mockSaveSecure() => when(storage.write(key: anyNamed('key'), value: anyNamed('value')));
  mockSaveSecureError() => mockSaveSecure().thenThrow(Exception());

  setUp(() {
    storage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: storage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  test('Should call save secure with correct values', () async {

    await sut.saveSecure(key: key, value: value);

    verify(storage.write(key: key, value: value));
  });

  test('Should throws UnexpectedError if save secure fails', () async {

    mockSaveSecureError();

    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });

}