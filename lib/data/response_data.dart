import 'package:json_annotation/json_annotation.dart';
import 'package:nkrv_bible/data/bible_book_count.dart';
import 'bible_item.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData<T> {

  ResponseData(this.response);

  @JsonKey(name: "result")
  @_Converter()
  final T response;

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {

    if (T == BibleItem) {
      return BibleItem.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == BibleBookCount) {
      return BibleBookCount.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == BibleItemList) {
      var result = <BibleItem>[];
      for (var item in json as List) {
        result.add(BibleItem.fromJson(item));
      }
      return BibleItemList(result) as T;
    }
    if (T == BibleBookCountList) {
      var result = <BibleBookCount>[];
      for (var item in json as List) {
        result.add(BibleBookCount.fromJson(item));
      }
      return BibleBookCountList(result) as T;
    }

    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}