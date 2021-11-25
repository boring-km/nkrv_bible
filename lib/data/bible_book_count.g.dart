// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_book_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleBookCount _$BibleBookCountFromJson(Map<String, dynamic> json) =>
    BibleBookCount(
      json['label'] as String,
      json['chapter'] as int,
      json['count'] as int,
    );

Map<String, dynamic> _$BibleBookCountToJson(BibleBookCount instance) =>
    <String, dynamic>{
      'label': instance.longLabel,
      'chapter': instance.chapter,
      'count': instance.count,
    };
