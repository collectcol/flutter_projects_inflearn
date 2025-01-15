import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // 배경 색깔
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.amber,
                  // 비활성화 되었을 때 색깔 (onPressed 에 null 을 넣을 때)
                  // 배경 위의 색깔
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.red,
                  // 비활성화 되었을 때 색깔 (onPressed 에 null 을 넣을 때)

                  shadowColor: Colors.blue,
                  elevation: 10.0,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),
                  padding: EdgeInsets.all(32.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 4.0,
                  ),
                  minimumSize: Size(200, 150),
                  // 최소
                  maximumSize: Size(300, 200),
                  // 최대
                  fixedSize: Size(250, 150), // 고정
                ),
                child: Text('Elevated Button'),
              ),
              OutlinedButton(
                onPressed: () {},
                // 기본적으로 모든 버튼은 스타일링 방법은 똑같다. 다만, 기본 스타일 설정이 다를뿐이다.
                // ElevatedButton이나 OutlinedButton이나 같다.
                // style: OutlinedButton.styleFrom(
                // ),

                style: ButtonStyle(
                  // Material State
                  // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태) -> 앱에서는 의미가 없음
                  // focused - 포커스 됐을 때 (텍스트 필드)
                  // pressed - 눌렀을 때
                  // dragged - 드래그 됐을 때
                  // selected - 선택 됐을 때 (체크박스, 라디오 버튼)
                  // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                  // disabled - 비활성화 됐을 때
                  // error - 에러 상태일 때
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(200, 150),
                  ),
                ),
                child: Text('Outlined Button'),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red;
                    }
                    return Colors.black;
                  },
                ), foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black;
                  }
                  return Colors.white;
                }), minimumSize: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Size(200, 150);
                  }

                  return Size(100, 100);
                })),
                child: Text('Text Button'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    // shape: StadiumBorder(), 둥근 원형 (기본형)
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(32.0)
                    // ), 직사각형(둥글게 radius로 가능)
                    // shape: BeveledRectangleBorder(
                    //   borderRadius: BorderRadius.circular(16.0),
                    // ), 직사각형(마름모? 가능)
                    // shape: ContinuousRectangleBorder(
                    //   borderRadius: BorderRadius.circular(16.0), 자연스러운 둥글게
                    // )
                    shape: CircleBorder(eccentricity: 1 // 가로로 넓어지는 원 형태
                        ) // 글자수가 작을 때 용이
                    ),
                child: Text('Outlined Button Shape'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_alt_outlined,
                ),
                label: Text('키보드'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_alt_outlined,
                ),
                label: Text('키보드'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_alt_outlined,
                ),
                label: Text('키보드'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
