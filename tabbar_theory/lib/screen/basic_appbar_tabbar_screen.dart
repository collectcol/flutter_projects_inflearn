import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppBarScreen'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: TabBar(
              indicatorColor: Colors.blue,
              indicatorWeight: 4.0,
              // label 로 넣으면 label 크기 만큼 indicator 크기가 맞춰진다.
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              // tab을 좌우로 스크롤 가능하게 해줌
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              // 선택시 굵게
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
              // 선택안된경우 얇게
              tabs: TABS
                  .map(
                    (e) => Tab(
                      icon: Icon(e.icon),
                      child: Text(e.label),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(), // 좌우 스와이프로 화면 이동 불가능하게 하기
          children: TABS
              .map(
                (e) => Center(
                  child: Icon(e.icon),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
