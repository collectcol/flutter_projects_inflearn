import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      children: [
        OutlinedButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteOneScreen(
                    number: 20,
                  );
                },
              ),
            );
          },
          child: Text('Push'),
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
            // Route Stack 에서 현재 스크린이 마지막 스크린이라면 Pop 이 안된다.
            Navigator.of(context).maybePop(
              456,
            );
          },
          child: Text('Maybe Pop'),
        ),
        OutlinedButton(
          onPressed: () {
            // Pop이 가능한지 true/false 를 반환
            print(Navigator.of(context).canPop());
          },
          child: Text('Can Pop'),
        ),
      ],
    );
  }
}
