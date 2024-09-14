import 'package:reflectable/reflectable.dart';

// تعریف یک کلاس Reflector برای بازتاب
class FormReflector extends Reflectable {
  const FormReflector()
      : super(invokingCapability, declarationsCapability, metadataCapability, typeCapability);
}

// ایجاد نمونه‌ای از Reflector
const reflector = FormReflector();