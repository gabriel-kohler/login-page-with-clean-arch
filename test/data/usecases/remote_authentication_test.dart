import 'package:faker/faker.dart';
import 'package:login_page_with_mobx/domain/usecases/authentication.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class HttpClient {
  Future<void>? request({
    required String? url,
    required String? method,
    Map body,
  });
}

@GenerateMocks([HttpClientSpy])
class HttpClientSpy extends Mock implements HttpClient {}

class RemoteAuthentication {
  final HttpClient? httpClient;
  final String? url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void>? auth(AuthenticationParams params) async {
    await httpClient!.request(url: url, method: 'post', body: params.toJson());
  }
}

void main() {
  HttpClientSpy? httpClient;
  String? url;
  RemoteAuthentication? sut;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpsUrl();

    //SUT (system under test)
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );

    await sut!.auth(params); //act

    verify(httpClient!.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.password}));
  });
}
