import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '/utils/utils.dart';

import '/ui/pages/pages.dart';

import '/domain/usecases/usecases.dart';

class GetxSplashPresenter implements SplashPresenter {

  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString(null);

  GetxSplashPresenter({@required this.loadCurrentAccount});

  @override
  Future<void> checkAccount() async {

    try {

      final account = await loadCurrentAccount.load();

      if (account == null) {
        _navigateTo.value = AppRoutes.WELCOME_PAGE;
      } else {
        _navigateTo.value = AppRoutes.HOME_PAGE;
      }

    } catch (error) {
      _navigateTo.value = AppRoutes.WELCOME_PAGE;
    }
    
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

}