import 'package:json_annotation/json_annotation.dart';
import 'package:nkrv_bible/data/bible_book_count.dart';

part 'bible_count_response_data.g.dart';

@JsonSerializable()
class BibleCountResponseData<T> {

  BibleCountResponseData(this.response);

  @JsonKey(name: "result")
  @_Converter()
  final T response;

  factory BibleCountResponseData.fromJson(Map<String, dynamic> json) => _$BibleCountResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BibleCountResponseDataToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return BibleBookCount.fromJson(json) as T;
    } else if (json is List) {
      var result = <BibleBookCount>[];
      for (var item in json) {
        result.add(BibleBookCount.fromJson(item));
      }
      return result as T;
    }
    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}