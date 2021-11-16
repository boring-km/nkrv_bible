// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData<T> _$ResponseDataFromJson<T>(Map<String, dynamic> json) =>
    ResponseData<T>(
      _Converter<T>().fromJson(json['result']),
    );

Map<String, dynamic> _$ResponseDataToJson<T>(ResponseData<T> instance) =>
    <String, dynamic>{
      'result': _Converter<T>().toJson(instance.response),
    };
