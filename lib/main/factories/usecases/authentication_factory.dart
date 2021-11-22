import 'package:flutter/material.dart';
import 'package:login_page_with_mobx/main/factories/http/http.dart';
import '/data/usecases/usecases.dart';
import '/domain/usecases/usecases.dart';

Authentication makeRemoteAuthentication() {

return RemoteAuthentication(
    httpClient: makeHttpAdapter(),
    url: makeAuthUrl('signInWithPassword'),
  );
}
