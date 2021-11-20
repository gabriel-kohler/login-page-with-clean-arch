import '/data/http/http.dart';

import '/domain/entities/entities.dart';

class RemoteAccountModel {

  final String accessToken;

  RemoteAccountModel(this.accessToken);
  
  factory RemoteAccountModel.fromJson(Map json) {

    if (!json.containsKey('idToken')) {
      throw HttpError.invalidData;
    }

    return new RemoteAccountModel(json['idToken']);
  }

  AccountEntity toAccountEntity() => new AccountEntity(accessToken);
}