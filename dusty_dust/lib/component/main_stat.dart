import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../utils/date_utils.dart';
import '../utils/status_utils.dart';

class MainStat extends StatelessWidget {
  final Region region;
  final Color primaryColor;
  final bool isExpanded;

  MainStat({
    super.key,
    required this.region, required this.primaryColor, required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 40.0,
    );

    return SliverAppBar(
      title: isExpanded ? null : Text(region.KrName),
      pinned: true,
      centerTitle: true,
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: FutureBuilder<StatModel?>(
                future: GetIt.I<Isar>()
                    .statModels
                    .filter()
                    .regionEqualTo(region)
                    .itemCodeEqualTo(ItemCode.PM10)
                    .sortByDateTimeDesc()
                    .findFirst(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('데이터가 없습니다.'),
                    );
                  }

                  final statModel = snapshot.data!;

                  final status = StatusUtils.getStatusModelFromStat(
                    statModel: statModel,
                  );

                  return Column(
                    children: [
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      Text(
                        region.KrName,
                        style: ts.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        DateUtils.DateTimeToString(dateTime: statModel.dateTime),
                        style: ts.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Image.asset(
                        status.imagePath,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        status.label,
                        style: ts.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        status.comment,
                        style: ts.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
