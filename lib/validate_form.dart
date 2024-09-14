import 'package:reflect_annotation_example/form_reflector.dart';
import 'package:reflectable/reflectable.dart';
import 'annotations.dart';

// تابع اعتبارسنجی فرم
List<String> validateForm(Object form) {
  List<String> errors = [];

  // ایجاد instance از فرم با استفاده از Reflectable
  var instanceMirror = reflector.reflect(form);
  var classMirror = reflector.reflectType(form.runtimeType) as ClassMirror;

  for (var field in classMirror.declarations.values) {
    if (field is VariableMirror) {
      var fieldValue = instanceMirror.invokeGetter(field.simpleName);

      // بررسی @Required
      var requiredAnnotation = field.metadata.firstWhere(
              (m) => m is Required, orElse: () => Object());  // استفاده از Object به جای null

      if (requiredAnnotation is Required &&
          (fieldValue == null || (fieldValue is String && fieldValue.isEmpty))) {
        errors.add('${field.simpleName} is required');
      }

// بررسی @MaxLength
      var maxLengthAnnotation = field.metadata.firstWhere(
              (m) => m is MaxLength, orElse: () => Object());  // استفاده از Object به جای null

      if (maxLengthAnnotation is MaxLength && fieldValue is String) {
        int maxLength = maxLengthAnnotation.length;
        if (fieldValue.length > maxLength) {
          errors.add('${field.simpleName} exceeds maximum length of $maxLength');
        }
      }
    }
  }

  return errors;
}