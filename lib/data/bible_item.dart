class BibleItem {
  String longLabel;
  int chapter;
  int paragraph;
  String sentence;

  BibleItem(this.longLabel, this.chapter, this.paragraph, this.sentence);

  @override
  String toString() {
    return 'BibleItem{longLabel: $longLabel, chapter: $chapter, paragraph: $paragraph, sentence: $sentence}';
  }
}