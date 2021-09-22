import '/data/http/http.dart';

import '/domain/entities/entities.dart';

class RemoteAccountModel {

  final String accessToken;

  RemoteAccountModel(this.accessToken);
  
  factory RemoteAccountModel.fromJson(Map? json) {

    if (!json!.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }

    return new RemoteAccountModel(json['accessToken']);
  } 

  AccountEntity toAccountEntity() => new AccountEntity(accessToken);
}