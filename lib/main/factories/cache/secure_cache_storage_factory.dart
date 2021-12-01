import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/data/cache/cache.dart';

import '/infra/cache/cache.dart';


SaveSecureCacheStorage makeSecureCacheStorage() {

  final flutterSecureStorage = FlutterSecureStorage();
  return LocalStorageAdapter(secureStorage: flutterSecureStorage);
}

FetchSecureCacheStorage makeLocalStorageAdapter() {
  final secureStorage = FlutterSecureStorage();
  return LocalStorageAdapter(secureStorage: secureStorage);
}