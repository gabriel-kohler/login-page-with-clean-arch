import 'package:meta/meta.dart';

import '/data/cache/cache.dart';

import '/domain/entities/entities.dart';
import '/domain/helpers/helpers.dart';

import '/domain/usecases/load_current_account.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetch(key: 'token');
      return AccountEntity(token);
    } catch (error) {
      throw DomainError.unexpected;
    }
    
  }
}