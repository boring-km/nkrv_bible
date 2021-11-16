
import 'package:json_annotation/json_annotation.dart';

part 'bible_item.g.dart';

@JsonSerializable()
class BibleItem {

  @JsonKey(name: 'label')
  final String longLabel;

  @JsonKey(name: 'chapter')
  final int chapter;

  @JsonKey(name: 'paragraph')
  final int paragraph;

  @JsonKey(name: 'sentence')
  final String sentence;

  BibleItem(this.longLabel, this.chapter, this.paragraph, this.sentence);

  factory BibleItem.fromJson(Map<String, dynamic> json) => _$BibleItemFromJson(json);

  Map<String, dynamic> toJson() => _$BibleItemToJson(this);

  @override
  String toString() {
    return 'BibleItem{longLabel: $longLabel, chapter: $chapter, paragraph: $paragraph, sentence: $sentence}';
  }
}