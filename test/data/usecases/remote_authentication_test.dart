import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class HttpClient {
  Future<void>? request({
    required String url,
    required String method,
  });
}

@GenerateMocks([HttpClientSpy])
class HttpClientSpy extends Mock implements HttpClient {}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void>? auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

void main() {
  test('Should call HttpClient with correct values', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpsUrl();
    //SUT (system under test)
    final sut =
        RemoteAuthentication(httpClient: httpClient, url: url); //arrange

    await sut.auth(); //act

    verify(httpClient.request(
      url: url,
      method: 'post',
    )); //assert
  });
}
