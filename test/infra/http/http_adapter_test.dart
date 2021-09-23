import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class HttpAdapter {

  final Client client;

  HttpAdapter(this.client); 

  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final newUrl = Uri.parse(url);
    await client.post(newUrl);
  }
}
class ClientSpy extends Mock implements Client{}
void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post');

      final newUrl = Uri.parse(url);

      verify(client.post(newUrl));
    });
  });
}
