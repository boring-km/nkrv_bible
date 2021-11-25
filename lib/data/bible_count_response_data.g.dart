// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_count_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleCountResponseData<T> _$BibleCountResponseDataFromJson<T>(
        Map<String, dynamic> json) =>
    BibleCountResponseData<T>(
      _Converter<T>().fromJson(json['result']),
    );

Map<String, dynamic> _$BibleCountResponseDataToJson<T>(
        BibleCountResponseData<T> instance) =>
    <String, dynamic>{
      'result': _Converter<T>().toJson(instance.response),
    };
