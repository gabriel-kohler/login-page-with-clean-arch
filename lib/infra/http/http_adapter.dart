import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = _jsonBody(body);

    var response = Response('', 500);

    if (method == 'post')
      try {
        response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      } catch (error) {
        throw HttpError.serverError;
      }

    return _handleResponse(response);
  }

  String _jsonBody(Map body) {
    if (body != null) {
      final newBody = FirebaseAdapter.fromHttpAdapter(body).toFirebase();
      return jsonEncode(newBody);
    }
    return null;
  }


  Map _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}

class FirebaseAdapter {
  final Map body;

  FirebaseAdapter(this.body);

  factory FirebaseAdapter.fromHttpAdapter(Map body) => FirebaseAdapter(body);

  Map toFirebase() {
    body['returnSecureToken'] = 'true';
    return body;
  }
}