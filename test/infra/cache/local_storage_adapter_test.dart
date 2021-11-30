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

  mockFetchCall() => when(storage.read(key: anyNamed('key')));
  mockFetchError() => mockFetchCall().thenThrow(Exception());
  mockFetch() => mockFetchCall().thenAnswer((_) async => 'any_token');

  setUp(() {
    storage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: storage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  

  group('Save', () {
    test('Should call save secure with correct values', () async {

    await sut.saveSecure(key: key, value: value);

    verify(storage.write(key: key, value: value)).called(1);
    });

    test('Should throws UnexpectedError if save secure fails', () async {

      mockSaveSecureError();

      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });

  });

  group('Fetch', () {
    test('Should call fetch with correct values', () async {
      
      await sut.fetch(key: 'token');

      verify(storage.read(key: 'token')).called(1);
    });
  });

  test('Should throw if fetch throws', () {

    mockFetchError();

    final future = sut.fetch(key: 'any_key');

    expect(future, throwsA(TypeMatcher<Exception>()));

  });

  test('Should return correct value on success', () async {

    mockFetch();

    final account = await sut.fetch(key: 'any_key');

    expect(account, 'any_token');
  });

}