import 'package:meta/meta.dart';

abstract class FetchSecureCacheStorage {
  Future<String> fetch({@required key});
}