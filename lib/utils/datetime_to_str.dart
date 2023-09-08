import 'package:date_format/date_format.dart';

enum StrDatetimeType {
  strDelimiter,
  dotDelimiter,
  hypenDelimiter,
  dotDelOnlyDate,
  strDelOnlyDate,
  hypenDelOnlyDate,
}

datetimeToStr(DateTime datetime, StrDatetimeType type) {
  switch (type) {
    case StrDatetimeType.strDelimiter:
      return formatDate(
          datetime, [m, "월 ", d, "일 ", D, "요일 ", am, " ", hh, ":", nn],
          locale: const KoreanDateLocale()); // 수정 - 한글/영어 택하게 수정
    case StrDatetimeType.dotDelimiter:
      return formatDate(datetime, [yyyy, ".", mm, ".", dd, " ", HH, ":", nn]);
    case StrDatetimeType.hypenDelimiter:
      return formatDate(datetime, [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
    case StrDatetimeType.dotDelOnlyDate:
      return formatDate(datetime, [yyyy, ".", mm, ".", dd]);
    case StrDatetimeType.strDelOnlyDate:
      return formatDate(datetime, [yyyy, "년 ", mm, "월 ", dd, "일 "]);
    case StrDatetimeType.hypenDelOnlyDate:
      return formatDate(datetime, [yyyy, "-", mm, "-", dd]);
  }
}
