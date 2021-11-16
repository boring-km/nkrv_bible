
import 'package:json_annotation/json_annotation.dart';

part 'bible_item.g.dart';

@JsonSerializable()
class BibleItem {

  @JsonKey(name: 'label')
  String longLabel;

  @JsonKey(name: 'chapter')
  int chapter;

  @JsonKey(name: 'paragraph')
  int paragraph;

  @JsonKey(name: 'sentence')
  String sentence;

  BibleItem(this.longLabel, this.chapter, this.paragraph, this.sentence);

  factory BibleItem.fromJson(Map<String, dynamic> json) => _$BibleItemFromJson(json);

  Map<String, dynamic> toJson() => _$BibleItemDataToJson(this);

  @override
  String toString() {
    return 'BibleItem{longLabel: $longLabel, chapter: $chapter, paragraph: $paragraph, sentence: $sentence}';
  }
}