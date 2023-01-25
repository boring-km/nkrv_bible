
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_ui_event.freezed.dart';

@freezed
abstract class BibleUiEvent<T> with _$BibleUiEvent<T> {
  const factory BibleUiEvent.showDialog(String message) = ShowDialog;
}