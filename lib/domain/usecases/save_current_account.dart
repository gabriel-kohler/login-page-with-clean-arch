import '/domain/entities/entities.dart';
import 'package:meta/meta.dart';

abstract class SaveCurrentAccount {
  Future<void> save({@required AccountEntity account});
}