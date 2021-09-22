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
  AuthenticationParams? params;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());

  });

  test('Should call HttpClient with correct values', () async {

    final name = faker.person.name();
    final accessToken = faker.guid.guid();

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenAnswer((_) async => {'accessToken': accessToken, 'name': name});

    await sut!.auth(params!);

    verify(httpClient!.request(url: url, method: 'post', body: {'email': params!.email, 'password': params!.password}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.badRequest);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.notFound);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.serverError);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 401', () async {

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.unauthorized);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {

    final name = faker.person.name();
    final accessToken = faker.guid.guid();

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenAnswer((_) async => {'accessToken': accessToken, 'name': name});

    final account = await sut!.auth(params!);

    expect(account.token, accessToken);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {

    when(httpClient!.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenAnswer((_) async => {'invalid_key': 'invalid_value'});

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));

  });
}


