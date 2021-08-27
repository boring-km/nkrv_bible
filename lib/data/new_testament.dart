enum NewTestament {
  Mat,
  Mar,
  Luk,
  Joh,
  Act,
  Rom,
  Co1,
  Co2,
  Gal,
  Eph,
  Phi,
  Col,
  Th1,
  Th2,
  Ti1,
  Ti2,
  Tit,
  Phm,
  Heb,
  Jam,
  Pe1,
  Pe2,
  Jo1,
  Jo2,
  Jo3,
  Jud,
  Rev
}

extension NewTestamentExtension on NewTestament {
  String get label {
    switch (this) {
      case NewTestament.Mat:
        return '마태복음';
      case NewTestament.Mar:
        return '마가복음';
      case NewTestament.Luk:
        return '누가복음';
      case NewTestament.Joh:
        return '요한복음';
      case NewTestament.Act:
        return '사도행전';
      case NewTestament.Rom:
        return '로마서';
      case NewTestament.Co1:
        return '고린도전서';
      case NewTestament.Co2:
        return '고린도후서';
      case NewTestament.Gal:
        return '갈라디아서';
      case NewTestament.Eph:
        return '에베소서';
      case NewTestament.Phi:
        return '빌립보서';
      case NewTestament.Col:
        return '골로새서';
      case NewTestament.Th1:
        return '데살로니가전서';
      case NewTestament.Th2:
        return '데살로니가후서';
      case NewTestament.Ti1:
        return '디모데전서';
      case NewTestament.Ti2:
        return '디모데후서';
      case NewTestament.Tit:
        return '디도서';
      case NewTestament.Phm:
        return '빌레몬서';
      case NewTestament.Heb:
        return '히브리서';
      case NewTestament.Jam:
        return '야고보서';
      case NewTestament.Pe1:
        return '베드로전서';
      case NewTestament.Pe2:
        return '베드로후서';
      case NewTestament.Jo1:
        return '요한1서';
      case NewTestament.Jo2:
        return '요한2서';
      case NewTestament.Jo3:
        return '요한3서';
      case NewTestament.Jud:
        return '유다서';
      case NewTestament.Rev:
        return '요한계시록';

      default:
        return '신약성서';
    }
  }
}