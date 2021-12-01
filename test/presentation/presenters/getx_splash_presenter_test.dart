import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:login_page_with_mobx/ui/pages/pages.dart';
import 'package:login_page_with_mobx/domain/usecases/load_current_account.dart';
import 'package:login_page_with_mobx/data/usecases/load_current_account/load_current_account.dart';
import 'package:login_page_with_mobx/domain/entities/account_entity.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';

class LocalLoadCurrentAccountSpy extends Mock implements LocalLoadCurrentAccount {}

class GetxSplashPresenter implements SplashPresenter {

  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString(null);

  GetxSplashPresenter({@required this.loadCurrentAccount});

  @override
  Future<void> checkAccount() async {
    final account = await loadCurrentAccount.load();
    
    if (account != null) {
      if (account.token?.isNotEmpty == true) {
      _navigateTo.value = AppRoutes.HOME_PAGE;
      }
    }
    
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

}

void main() {

  LocalLoadCurrentAccountSpy loadCurrentAccountSpy;
  GetxSplashPresenter sut;

  setUp(() {
    loadCurrentAccountSpy = LocalLoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccountSpy);
  });

  test('Should call LoadCurrentAccount', () async {

    await sut.checkAccount();

    verify(loadCurrentAccountSpy.load()).called(1);
  });

  test('Should go to home page on success', () async {

    when(loadCurrentAccountSpy.load()).thenAnswer((_) async => AccountEntity('any_value'));

    sut.navigateToStream.listen(
      expectAsync1(
        (page) {
        expect(page, AppRoutes.HOME_PAGE);
        }
      ),
    );

    await sut.checkAccount();

  });
}