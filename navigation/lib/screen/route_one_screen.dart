import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int number;

  const RouteOneScreen({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 시스템에서 사용하는 뒤로가기 기능 적용 유무설정(앱바의 뒤로가기, 단말기의 취소(뒤로)버튼)
      canPop: false,
      child: DefaultLayout(
        title: 'RouteOneScreen',
        children: [
          Text(
            'argument: $number',
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(
                456,
              );
            },
            child: Text('Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).maybePop(
                456,
              );
            },
            child: Text('Maybe Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteTwoScreen();
                  },
                  settings: RouteSettings(
                    arguments: 789,
                  ),
                ),
              );
            },
            child: Text('Push'),
          ),
          OutlinedButton(
            onPressed: () {
              // Pop이 가능한지 true/false 를 반환
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),
        ],
      ),
    );
  }
}
