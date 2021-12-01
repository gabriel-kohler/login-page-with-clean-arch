import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

import 'package:login_page_with_mobx/utils/utils.dart';
import 'package:login_page_with_mobx/data/usecases/usecases.dart';
import 'package:login_page_with_mobx/domain/entities/entities.dart';
import 'package:login_page_with_mobx/presentation/presenters/presenters.dart';

class LocalLoadCurrentAccountSpy extends Mock implements LocalLoadCurrentAccount {}

void main() {

  LocalLoadCurrentAccountSpy loadCurrentAccountSpy;
  GetxSplashPresenter sut;

  PostExpectation mockLoadCurrentAccountCall() => when(loadCurrentAccountSpy.load());
  void mockLoadCurrentAccount({AccountEntity account}) => mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  void mockLoadCurrentAccountError() => mockLoadCurrentAccountCall().thenThrow(Exception());

  setUp(() {
    loadCurrentAccountSpy = LocalLoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccountSpy);
  });

  test('Should call LoadCurrentAccount', () async {

    await sut.checkAccount();

    verify(loadCurrentAccountSpy.load()).called(1);
  });

  test('Should go to home page on success', () async {

    mockLoadCurrentAccount(account: AccountEntity('any_value'));

    sut.navigateToStream.listen(
      expectAsync1(
        (page) {
        expect(page, AppRoutes.HOME_PAGE);
        }
      ),
    );

    await sut.checkAccount();

  });

  test('Should go to login page on null result', () async {

    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(
      expectAsync1((page) { 
        expect(page, AppRoutes.LOGIN_PAGE);
      }),
    );

    await sut.checkAccount();
    
  });

  test('Should go to login page on error', () async {

    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(
      expectAsync1((page) { 
        expect(page, AppRoutes.LOGIN_PAGE);
      }),
    );

    await sut.checkAccount();
    
  });
}