// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleResponseData<T> _$BibleResponseDataFromJson<T>(
        Map<String, dynamic> json) =>
    BibleResponseData<T>(
      _Converter<T>().fromJson(json['result']),
    );

Map<String, dynamic> _$BibleResponseDataToJson<T>(
        BibleResponseData<T> instance) =>
    <String, dynamic>{
      'result': _Converter<T>().toJson(instance.response),
    };
