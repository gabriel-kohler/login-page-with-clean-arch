import 'package:meta/meta.dart';

abstract class FieldValidation {
  String get field;
  String validate({@required String value});
}