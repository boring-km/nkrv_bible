import 'package:json_annotation/json_annotation.dart';

part 'bible_book_count.g.dart';

@JsonSerializable()
class BibleBookCount {

  @JsonKey(name: 'label')
  String longLabel;

  @JsonKey(name: 'chapter')
  int chapter;

  @JsonKey(name: 'count')
  int count;

  BibleBookCount(this.longLabel, this.chapter, this.count);

  factory BibleBookCount.fromJson(Map<String, dynamic> json) => _$BibleBookCountFromJson(json);

  Map<String, dynamic> toJson() => _$BibleBookCountToJson(this);

  @override
  String toString() {
    return 'BibleBookCount{longLabel: $longLabel, chapter: $chapter, count: $count}';
  }
}

class BibleBookCountList {
  final List<BibleBookCount> list;

  BibleBookCountList(this.list);
}