import 'dart:convert';

extension StringExt on String {
  dynamic toJson() => jsonDecode(this);
}
