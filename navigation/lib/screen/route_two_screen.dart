import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return DefaultLayout(
      title: 'RouteTwoScreen',
      children: [
        Text(
          arguments.toString(),
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 111111,
            );
          },
          child: Text('Push Route Three'),
        ),
        OutlinedButton(
          onPressed: () {
            // pushReplacement -> push 를 호출하는 스택은 삭제되고 호출당하는 스택이 오게됨
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteThreeScreen();
                },
                settings: RouteSettings(
                  arguments: 998,
                )
              ),
            );
          },
          child: Text('Push Replacement'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Replacement Named'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) {
                // 만약에 삭제 할거면 (Route Stack) false 반환
                // 만약에 삭제를 안할거면 true 반환
                
                // 먄약 home 인 경우 home을 제외한 나머지 스택은 모두 삭제
                return route.settings.name == '/';
              },
              arguments: 999,
            );
          },
          child: Text('Push Named And Remove Until'),
        ),
      ],
    );
  }
}
