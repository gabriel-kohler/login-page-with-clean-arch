import 'package:login_page_with_mobx/domain/entities/account_entity.dart';

abstract class Authentication {
  
  Future<AccountEntity> auth({
    required String email,
    required String password,
  });
}
