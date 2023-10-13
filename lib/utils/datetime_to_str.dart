import 'package:date_format/date_format.dart';

enum StrDatetimeType {
  strDelimiter,
  dotDelimiter,
  hypenDelimiter,
  dotDelOnlyDate,
  strDelOnlyDate,
  hypenDelOnlyDate,
}

datetimeToStr(DateTime datetime, StrDatetimeType type, {String lang = "ko"}) {
  switch (type) {
    case StrDatetimeType.strDelimiter:
      return formatDate(
          datetime,
          lang == "ko"
              ? [m, "월 ", d, "일 ", D, "요일 ", am, " ", hh, ":", nn]
              : [M, " ", d, " ", D, " ", am, " ", hh, ":", nn],
          locale: lang == "ko"
              ? const KoreanDateLocale()
              : const EnglishDateLocale());
    case StrDatetimeType.dotDelimiter:
      return formatDate(datetime, [yyyy, ".", mm, ".", dd, " ", HH, ":", nn]);
    case StrDatetimeType.hypenDelimiter:
      return formatDate(
          datetime, [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
    case StrDatetimeType.dotDelOnlyDate:
      return formatDate(datetime, [yyyy, ".", mm, ".", dd]);
    case StrDatetimeType.strDelOnlyDate:
      return formatDate(
          datetime,
          lang == "ko"
              ? [yyyy, "년 ", m, "월 ", dd, "일 "]
              : [yyyy, " ", M, " ", dd],
          locale: lang == "ko"
              ? const KoreanDateLocale()
              : const EnglishDateLocale());
    case StrDatetimeType.hypenDelOnlyDate:
      return formatDate(datetime, [yyyy, "-", mm, "-", dd]);
  }
}
