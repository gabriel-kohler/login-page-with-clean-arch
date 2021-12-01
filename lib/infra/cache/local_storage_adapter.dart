import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '/data/cache/cache.dart';
import 'package:meta/meta.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage, FetchSecureCacheStorage {

  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({@required this.secureStorage});

  @override
  Future<void> saveSecure({@required String key,@required String value}) async {
      await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String> fetch({@required key}) async {
    final token = await secureStorage.read(key: key);
    return token;
  }
}