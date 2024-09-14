import 'package:reflect_annotation_example/form_reflector.dart';

import 'annotations.dart';

@reflector
class UserForm {
  @Required()
  String? name;

  @Required()
  @MaxLength(10)
  String? username;

  UserForm({this.name, this.username});
}