import 'package:login_page_with_mobx/domain/entities/account_entity.dart';

class RemoteAccountModel {

  final String accessToken;

  RemoteAccountModel(this.accessToken);
  
  factory RemoteAccountModel.fromJson(Map? json) => new RemoteAccountModel(json!['accessToken']);

  AccountEntity toAccountEntity() => new AccountEntity(accessToken);
}