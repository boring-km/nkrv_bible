class BibleItem {
  String longLabel;
  int chapter;
  int paragraph;
  late String sentence;
// regexp_replace(sentence, '<[^>]*> ', '')

  BibleItem(this.longLabel, this.chapter, this.paragraph, String sentence) {
    this.sentence = sentence.replaceAll(RegExp('<[^>]*> '), '');
  }

  @override
  String toString() {
    return 'BibleItem{longLabel: $longLabel, chapter: $chapter, paragraph: $paragraph, sentence: $sentence}';
  }
}