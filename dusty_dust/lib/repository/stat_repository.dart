import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../model/stat_model.dart';

class StatRepository {
  static Future<void> fetchData() async {
    final isar = GetIt.I<Isar>();

    final now = DateTime.now();
    final compareDateTimeTarget = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final count = await isar.statModels.filter().dateTimeEqualTo(compareDateTimeTarget).count();

    // if (count > 0) {
    //   print('데이터가 존재합니다 : count : $count');
    //   return;
    // }

    for (ItemCode itemCode in ItemCode.values) {
      await fetchDataByItemCode(itemCode: itemCode);
    }
  }
  static Future<List<StatModel>> fetchDataByItemCode({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
        'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
        queryParameters: {
          'serviceKey':
              'tgPOvalcF9/RxpP5d2ZNQHrgZ+UBN7opjuoP7R9tbF9PGG8Wj+njr1eaGgYgGq2E8sxos9H8Szx7gOZMgRSOng==',
          'returnType': 'json',
          'numOfRows': 100,
          'pageNo': 1,
          'itemCode': itemCode.name,
          'dataGubun': 'HOUR',
          'searchCondition': 'WEEK',
        });

    final rawItemsList = response.data['response']['body']['items'];

    List<StatModel> stats = [];

    final List<String> skipKeys = [
      'dataGubun',
      'dataTime',
      'itemCode',
    ];

    for (Map<String, dynamic> item in rawItemsList) {
      final dateTime = DateTime.parse(item['dataTime']);

      for (String key in item.keys) {
        if (skipKeys.contains(key)) continue;

        // 지역 - key
        final regionStr = key;
        // 해당 지역의 값 - value
        final stat = double.parse(item[regionStr]);
        final region = Region.values.firstWhere((e) => e.name == regionStr);

        final statModel = StatModel()
          ..region = region
          ..stat = stat
          ..dateTime = dateTime
          ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        final count = await isar.statModels
            .filter()
            .regionEqualTo(region)
            .dateTimeEqualTo(dateTime)
            .itemCodeEqualTo(itemCode)
            .count();

        if (count > 0) {
          continue;
        }

        await isar.writeTxn(() async {
          await isar.statModels.put(statModel);
        });

        // stats = [
        //   ...stats,
        //   StatModel(
        //     region: Region.values.firstWhere((e) => e.name == regionStr),
        //     stat: double.parse(stat),
        //     dateTime: DateTime.parse(dateTime),
        //     itemCode: itemCode,
        //   ),
        // ];
      }
    }

    return stats;
  }
}
