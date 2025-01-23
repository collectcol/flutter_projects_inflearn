import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // 최대 높이
  double get maxExtent => maxHeight;

  @override
  // 최소 높이
  double get minExtent => minHeight;

  @override
  // covariant - 상속된 클래스도 사용가능
  // -> covariant 안쓰고 바로 _SliverFixedHeaderDelegate 사용가능
  // oldDelegate - build 가 실행이 되었을 때 이전 Delegate
  // this - 새로운 delegate
  // shouldRebuild - 새로 build 를 해야할지 말지 결정
  // return 값이 false 면 build 안함, true 면 빌드 다시함
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    final old = (oldDelegate as _SliverFixedHeaderDelegate);
    return old.minHeight != minHeight ||
        old.maxHeight != maxHeight ||
        old.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderBuilderChildSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      // 헤더가 쌓이게 된다.
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text('신기하지', style: TextStyle(color: Colors.white,),),
          ),
        ),
        minHeight: 75,
        maxHeight: 150,
      ),
    );
  }

  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 위로 스크롤 할 때 잠깐 Appbar가 보이는것
      floating: true,
      // 스크롤해도 Appbar가 고정되어있음
      pinned: false,
      // 살짝만 스크롤 해도 Appbar가 보임(자석효과)
      snap: true,
      // floating = true, pinned = false 로 되어 있어야됨.
      // 맨 위에서 한계 이상으로 스크롤을 내렸을 때 Appbar 의 배경이 늘어나서 보이게됨 (ios 기본설정의 경우 해당됨)
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      // Appbar 공간에 widget 보이게 가능
      flexibleSpace: FlexibleSpaceBar(
        // Appbar의 배경을 설정가능 (스크롤 하면 자연스럽게 없어짐)
        // background: Image.asset(name, fit: BoxFit.cover,),
        title: Text('FilexibleSpace'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  // ListView 기본 생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  // ListView.builder 생성자와 유사함.
  SliverList renderBuilderChildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
    );
  }

  // GridView.count 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // GridView.builder 와 비슷함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
