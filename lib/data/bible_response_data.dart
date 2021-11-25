import 'package:json_annotation/json_annotation.dart';

import 'bible_item.dart';

part 'bible_response_data.g.dart';

@JsonSerializable()
class BibleResponseData<T> {

  BibleResponseData(this.response);

  @JsonKey(name: "result")
  @_Converter()
  final T response;

  factory BibleResponseData.fromJson(Map<String, dynamic> json) => _$BibleResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BibleResponseDataToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return BibleItem.fromJson(json) as T;
    } else if (json is List) {
      var result = <BibleItem>[];
      for (var item in json) {
        result.add(BibleItem.fromJson(item));
      }
      return result as T;
    }
    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}