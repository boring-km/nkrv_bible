enum OldTestament {
  Gen,
  Exo,
  Lev,
  Num,
  Deu,
  Jos,
  Jdg,
  Rut,
  Sa1,
  Sa2,
  Ki1,
  Ki2,
  Ch1,
  Ch2,
  Ezr,
  Neh,
  Est,
  Job,
  Psa,
  Pro,
  Ecc,
  Sol,
  Isa,
  Jer,
  Lam,
  Eze,
  Dan,
  Hos,
  Joe,
  Amo,
  Oba,
  Jon,
  Mic,
  Nah,
  Hab,
  Zep,
  Hag,
  Zec,
  Mal
}

extension OldTestamentExtension on OldTestament {
  String get label {
    switch (this) {
      case OldTestament.Gen:
        return '창세기';
      case OldTestament.Exo:
        return '출애굽기';
      case OldTestament.Lev:
        return '레위기';
      case OldTestament.Num:
        return '민수기';
      case OldTestament.Deu:
        return '신명기';
      case OldTestament.Jos:
        return '여호수아';
      case OldTestament.Jdg:
        return '사사기';
      case OldTestament.Rut:
        return '룻기';
      case OldTestament.Sa1:
        return '사무엘상';
      case OldTestament.Sa2:
        return '사무엘하';
      case OldTestament.Ki1:
        return '열왕기상';
      case OldTestament.Ki2:
        return '열왕기하';
      case OldTestament.Ch1:
        return '역대상';
      case OldTestament.Ch2:
        return '역대하';
      case OldTestament.Ezr:
        return '에스라';
      case OldTestament.Neh:
        return '느헤미야';
      case OldTestament.Est:
        return '에스더';
      case OldTestament.Job:
        return '욥기';
      case OldTestament.Psa:
        return '시편';
      case OldTestament.Pro:
        return '잠언';
      case OldTestament.Ecc:
        return '전도서';
      case OldTestament.Sol:
        return '아가';
      case OldTestament.Isa:
        return '이사야';
      case OldTestament.Jer:
        return '예레미야';
      case OldTestament.Lam:
        return '예레미야애가';
      case OldTestament.Eze:
        return '에스겔';
      case OldTestament.Dan:
        return '다니엘';
      case OldTestament.Hos:
        return '호세아';
      case OldTestament.Joe:
        return '요엘';
      case OldTestament.Amo:
        return '아모스';
      case OldTestament.Oba:
        return '오바다';
      case OldTestament.Jon:
        return '요나';
      case OldTestament.Mic:
        return '미가';
      case OldTestament.Nah:
        return '나홈';
      case OldTestament.Hab:
        return '하박국';
      case OldTestament.Zep:
        return '스바냐';
      case OldTestament.Hag:
        return '학개';
      case OldTestament.Zec:
        return '스가랴';
      case OldTestament.Mal:
        return '말라기';
      default:
        return '구약성서';
    }
  }
}