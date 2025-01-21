import 'dart:io';

import 'package:calendar_scheduler/model/category.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

// 다른 파일을 하나의 파일로 인식 할 수 있게끔 하는 키워드 part
part 'drift.g.dart';

@DriftDatabase(tables: [ScheduleTable, CategoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<int> createCategory(CategoryTableCompanion data) => into(categoryTable).insert(data);

  Future<List<CategoryTableData>> getCategories() => select(categoryTable).get();

  Future<ScheduleWithCategory> getScheduleById(int id) {

    final query = select(scheduleTable).join([
      innerJoin(
        categoryTable,
        categoryTable.id.equalsExp(scheduleTable.colorId),
      ),
    ])..where(scheduleTable.id.equals(id));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(category: category, schedule: schedule);
    }).getSingle();

    // (select(scheduleTable)..where((table) => table.id.equals(id)))
    //     .getSingle();
  }

  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      (update(scheduleTable)..where((table) => table.id.equals(id)))
          .write(data);

  // 데이터를 가져올때는 Data 를 붙이지만
  Future<List<ScheduleTableData>> getSchedules(
    DateTime date,
  ) {
    return (select(scheduleTable)..where((table) => table.date.equals(date)))
        .get();

    final selectQuery = select(scheduleTable);
    selectQuery.where((table) => table.date.equals(date));

    return selectQuery.get();
  }

  Stream<List<ScheduleWithCategory>> streamSchedules(
    DateTime date,
  ) {
    final query = select(scheduleTable).join([
      innerJoin(
        categoryTable,
        categoryTable.id.equalsExp(scheduleTable.colorId),
      ),
    ])..where(scheduleTable.date.equals(date));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(category: category, schedule: schedule);
    }).watch();
    // (select(scheduleTable)
    //   ..where(
    //         (table) => table.date.equals(date),
    //   )
    //   ..orderBy([
    //         (table) => OrderingTerm(
    //       expression: table.startTime,
    //       mode: OrderingMode.asc,
    //     ),
    //         (table) => OrderingTerm(
    //       expression: table.endTime,
    //       mode: OrderingMode.asc,
    //     ),
    //   ]))
    //     .watch();
  }

  // 데이터를 업데이트하거나 생성할때는 Companion 을 붙인다.
  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> removeSchedule(int id) => (delete(scheduleTable)
        ..where(
          (table) => table.id.equals(id),
        ))
      .go();

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(categoryTable, categoryTable.randomNumber);
        }

        if (from < 3) {
          await m.addColumn(categoryTable, categoryTable.randomNumber2);
        }
      }
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      // 앱에 지정된 문서 가져오기
      final dbFolder = await getApplicationDocumentsDirectory();
      // windows : C:\\Users\flutter
      // macos : /Users/flutter
      // 현재 운영체재에 맞춰서 경로를 맞춰준다
      // /Users/codefactory/calendar_scheduler/db.sqlite
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      if (Platform.isAndroid) {
        // 안드로이드가 옜날버전이면 오류가 안나도록 실행하는 함수
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      // 앱을 실행하면 배정받는 임시폴더가 어디있는지 가져오기
      final cachebase = await getTemporaryDirectory();

      // 굳이 안해도 실행은 되지만 이렇게 해주면 안전하다고 함
      sqlite3.tempDirectory = cachebase.path;

      return NativeDatabase.createInBackground(file);
    },
  );
}
