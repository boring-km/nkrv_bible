// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleItem _$BibleItemFromJson(Map<String, dynamic> json) => BibleItem(
      json['label'] as String,
      json['chapter'] as int,
      json['paragraph'] as int,
      json['sentence'] as String,
    );

Map<String, dynamic> _$BibleItemToJson(BibleItem instance) => <String, dynamic>{
      'label': instance.longLabel,
      'chapter': instance.chapter,
      'paragraph': instance.paragraph,
      'sentence': instance.sentence,
    };
