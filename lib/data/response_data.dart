import 'package:json_annotation/json_annotation.dart';

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
    // if (json is Map<String, dynamic>) {
    //
    // }
    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}