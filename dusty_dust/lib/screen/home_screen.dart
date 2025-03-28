import 'dart:ffi';

import 'package:dusty_dust/component/hourly_stat.dart.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../component/category_stat.dart';
import '../component/main_stat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Region region = Region.busan;
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    StatRepository.fetchData();

    scrollController.addListener((){
      // kToolbarHeight -> 기본 앱바 높이
      bool isExpanded = scrollController.offset < (500 - kToolbarHeight);

      if (isExpanded != this.isExpanded) {
        setState(() {
          this.isExpanded = isExpanded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
        future: GetIt.I<Isar>()
            .statModels
            .filter()
            .regionEqualTo(region)
            .itemCodeEqualTo(ItemCode.PM10)
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }

          final statModel = snapshot.data!;
          final statusModel = StatusUtils.getStatusModelFromStat(
            statModel: statModel,
          );
          return Scaffold(
            drawer: Drawer(
              backgroundColor: statusModel.darkColor,
              child: ListView(
                children: [
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    child: Text(
                      '지역 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  ...Region.values.map(
                    (e) => ListTile(
                      selected: e == region,
                      tileColor: Colors.white,
                      selectedTileColor: statusModel.lightColor,
                      selectedColor: Colors.black,
                      onTap: () {
                        setState(() {
                          region = e;
                        });
                        Navigator.of(context).pop();
                      },
                      title: Text(e.KrName),
                    ),
                  ),
                ],
              ),
            ),
            // appBar: AppBar(
            //   backgroundColor: statusModel.primaryColor,
            //   surfaceTintColor: statusModel.primaryColor,
            // ),
            backgroundColor: statusModel.primaryColor,
            body: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainStat(
                  region: region,
                  primaryColor: statusModel.primaryColor,
                  isExpanded: isExpanded,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [

                      CategoryStat(
                        region: region,
                        darkColor: statusModel.darkColor,
                        lightColor: statusModel.lightColor,
                      ),
                      HourlyStat(
                        region: region,
                        darkColor: statusModel.darkColor,
                        lightColor: statusModel.lightColor,
                      ),
                    ],
                  ),
                )
              ]
              // Column(
              //   children: [
              //     MainStat(
              //       region: region,
              //     ),
              //     CategoryStat(
              //       region: region,
              //       darkColor: statusModel.darkColor,
              //       lightColor: statusModel.lightColor,
              //     ),
              //     HourlyStat(
              //       region: region,
              //       darkColor: statusModel.darkColor,
              //       lightColor: statusModel.lightColor,
              //     ),
              //   ],
              // ),
            ),
          );
        });
  }
}
