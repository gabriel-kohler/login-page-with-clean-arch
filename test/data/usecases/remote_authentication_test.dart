import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_page_with_mobx/data/usecases/remote_authentication.dart';
import 'package:login_page_with_mobx/domain/helpers/domain_error.dart';
import 'package:login_page_with_mobx/domain/usecases/authentication.dart';
import 'package:mockito/mockito.dart';

import 'package:login_page_with_mobx/data/http/http.dart';


class HttpClientSpy extends Mock implements HttpClient {}

void main() {

  String? url;
  HttpClientSpy? httpClient;
  RemoteAuthentication? sut;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {

    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());

    await sut!.auth(params);

    verify(httpClient!.request(url: url, method: 'post', body: {'email': params.email, 'password': params.password}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {

    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.badRequest);

    final future = sut!.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
