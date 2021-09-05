class BibleBookCount {
  String longLabel;
  int chapter;
  int count;

  BibleBookCount(this.longLabel, this.chapter, this.count);

  @override
  String toString() {
    return 'BibleBookCount{longLabel: $longLabel, chapter: $chapter, count: $count}';
  }
}