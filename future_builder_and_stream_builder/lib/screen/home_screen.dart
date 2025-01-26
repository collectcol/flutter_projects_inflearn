import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool onSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // futurebuilder 는 기존에 받았던 데이터가 있다면 cashing 이 되어 있다.
      // hot reload 를 하면 기존에 데이터를 가지고 있다가 future 함수(getNumber()) 을 실행해서 받은 데이터로 다시 빌드 한다.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (!onSwitch) onSwitch = true;
                  });
                },
                child: Text('Future 실행'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (onSwitch) onSwitch = false;
                  });
                },
                child: Text('Stream 실행'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          onSwitch
              ? _FutureInstall<int>(
            futureFuntion: getNumber,
            asyncWidgetBuilder: asyncWidgetBuilder,
          )
              : _StreamInstall<int>(
            streamFuntion: streamNumbers,
            asyncWidgetBuilder: asyncWidgetBuilder,
          ),
        ],
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    // throw '에러!!!';

    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 500));

      yield i;
    }
  }

  Widget asyncWidgetBuilder(BuildContext context, AsyncSnapshot<int> snapshot) {
    print('---- data ----');
    print(snapshot.connectionState); //  wating -> done 으로 바뀜
    print(snapshot.data);

    // Future:
    //
    // none: Future가 입력되지 않음 -> future 속성에 null 이 입력되어 있을 때
    // waiting: Future 실행 중
    // done: Future 완료
    //
    // Stream:
    //
    // none: Stream이 입력되지 않음 -> stream 속성에 null 이 입력되어 있을 때
    // waiting: 첫 데이터 대기 중
    // active: Stream 실행 중, 데이터 수신 중
    // done: Stream 종료

    /// 상태를 가지고 분기처리가능
    if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
      /// 다른 위젯을 보여준다.
      return SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(),
            Text(snapshot.data.toString()),
          ],
        ),
      );
    }

    /// error
    if (snapshot.hasError) {
      final error = snapshot.error;

      return Center(
        child: Text('에러: $error'),
      );
    }

    /// 데이터가 존재하는지 확인
    if (snapshot.hasData) {
      final data = snapshot.data;

      return Center(
        child: Text(data.toString()),
      );
    }

    return Center(
      child: Text('데이터가 없습니다.'),
    );
  }
}

class _FutureInstall<T> extends StatefulWidget {
  final Future<T> Function()? futureFuntion;
  final AsyncWidgetBuilder<T> asyncWidgetBuilder;

  const _FutureInstall({
    Key? key,
    required this.futureFuntion,
    required this.asyncWidgetBuilder,
  }) : super(key: key);

  @override
  State<_FutureInstall<T>> createState() => _FutureInstallState<T>();
}

class _FutureInstallState<T> extends State<_FutureInstall<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.futureFuntion?.call(),
      builder: widget.asyncWidgetBuilder,
    );
  }
}

class _StreamInstall<T> extends StatefulWidget {
  final Stream<T> Function()? streamFuntion;
  final AsyncWidgetBuilder<T> asyncWidgetBuilder;

  const _StreamInstall({
    Key? key,
    required this.streamFuntion,
    required this.asyncWidgetBuilder,
  }) : super(key: key);

  @override
  State<_StreamInstall<T>> createState() => _StreamInstallState<T>();
}

class _StreamInstallState<T> extends State<_StreamInstall<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.streamFuntion?.call(),
      builder: widget.asyncWidgetBuilder,
    );
  }
}
