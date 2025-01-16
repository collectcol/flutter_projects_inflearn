import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Column(
          children: [
            /// 1) 로고
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'LIVE',
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// 2) 이미지'
            Expanded(
              child: Center(
                child: Image.asset(
                  'asset/img/home_img.png',
                ),
              ),
            ),

            /// 3) 버튼
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('입장하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
