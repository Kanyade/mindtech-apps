import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

abstract final class JsonConverters {
  static const yyyyMMdd = _DateConverter('yyyy-MM-dd');
  static const yyyyMMddTHHmmss = _DateConverter("yyyy-MM-dd'T'HH:mm:ss");
}

abstract final class JsonConvertersNullable {
  static const yyyyMMdd = _DateConverterNullable('yyyy-MM-dd');
  static const yyyyMMddTHHmmss = _DateConverterNullable("yyyy-MM-dd'T'HH:mm:ss");
}

class _DateConverterNullable implements JsonConverter<DateTime?, String?> {
  const _DateConverterNullable(this._dateFormat);

  final String _dateFormat;

  @override
  DateTime? fromJson(String? json) {
    return json == null ? null : DateFormat(_dateFormat).parse(json);
  }

  @override
  String? toJson(DateTime? object) {
    return object == null ? null : DateFormat(_dateFormat).format(object);
  }
}

class _DateConverter implements JsonConverter<DateTime, String> {
  const _DateConverter(this._dateFormat);

  final String _dateFormat;

  @override
  DateTime fromJson(String json) {
    return DateFormat(_dateFormat).parse(json);
  }

  @override
  String toJson(DateTime object) {
    return DateFormat(_dateFormat).format(object);
  }
}
