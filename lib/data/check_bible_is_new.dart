import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';

bool isNewTestament(String label) {
  for (var item in NewTestament.values) {
    if (item.label == label) {
      return true;
    }
  }
  return false;
}

Map<Object, Object> getOldOrNewLabel(int index) {
  final isOld = index < 39;
  String label = isOld ? OldTestament.values[index].label : NewTestament.values[index-39].label;
  return {"isOld": isOld, "label": label};
}