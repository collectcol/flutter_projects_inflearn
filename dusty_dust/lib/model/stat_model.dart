// "daegu" "chungnam" "incheon" "daejeon" "gyeongbuk" "sejong" "gwangju"
// "jeonbuk"
// "gangwon"
// "ulsan"
// "jeonnam"
// "seoul"
// "busan"
// "jeju"
// "chungbuk"
// "gyeongnam"
// "gyeonggi"

import 'package:isar/isar.dart';

part 'stat_model.g.dart';

enum Region {
  daegu,
  chungnam,
  incheon,
  daejeon,
  gyeongbuk,
  sejong,
  gwangju,
  jeonbuk,
  gangwon,
  ulsan,
  jeonnam,
  seoul,
  busan,
  jeju,
  chungbuk,
  gyeongnam,
  gyeonggi;

  String get KrName {
    switch (this) {
      case Region.daegu:
        return '대구';
      case Region.chungnam:
        return '충남';
      case Region.incheon:
        return '인천';
      case Region.daejeon:
        return '대전';
      case Region.gyeongbuk:
        return '경북';
      case Region.sejong:
        return '세종';
      case Region.gwangju:
        return '광주';
      case Region.jeonbuk:
        return '전북';
      case Region.gangwon:
        return '강원';
      case Region.ulsan:
        return '울산';
      case Region.jeonnam:
        return '전남';
      case Region.seoul:
        return '서울';
      case Region.busan:
        return '부산';
      case Region.jeju:
        return '제주';
      case Region.chungbuk:
        return '충북';
      case Region.gyeongnam:
        return '경남';
      case Region.gyeonggi:
        return '경기';
      default:
        throw Exception('존재하지 않는 지역이름입니다.');
    }
  }
}

enum ItemCode {
  SO2,
  CO,
  O3,
  NO2,
  PM10,
  PM25;

  String get KrName {
    switch (this) {
      case ItemCode.SO2:
        return '이황산가스';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
    }
  }
}
// "dataTime": "2025-01-24 18:00",
// "itemCode": "PM10"
// "dataGubun": "1",

@collection
class StatModel {
  Id id = Isar.autoIncrement;
  // 지역
  @enumerated
  @Index(unique: true, composite: [
    CompositeIndex('dateTime'),
    CompositeIndex('itemCode'),
  ])
  late Region region;

  // 통계 값
  late double stat;

  // 날짜
  late DateTime dateTime;

  // 미세먼지 / 초세먼지
  @enumerated
  late ItemCode itemCode;
}
