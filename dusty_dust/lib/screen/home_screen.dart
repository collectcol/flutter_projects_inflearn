import 'package:dusty_dust/component/hourly_stat.dart.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
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

  @override
  void initState() {
    super.initState();

    StatRepository.fetchData(itemCode: ItemCode.PM10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<StatModel>>(
          future: StatRepository.fetchData(
            itemCode: ItemCode.PM10,
          ),
          builder: (context,snapshot) {
            return Column(
              children: [
                MainStat(),
                CategoryStat(),
                HourlyStat(),
              ],
            );
          }
        ),
      ),
    );
  }
}
