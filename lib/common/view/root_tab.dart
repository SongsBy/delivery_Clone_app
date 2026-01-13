import 'package:flutter/material.dart';
import 'package:project01/common/const/colors.dart';
import 'package:project01/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
   controller = TabController(length: 4, vsync: this); //vsync에는  SingleTickerProviderStateMixin 이 필수 이다
    // 2. 리스너 부착 (감시자 붙이기)
// 컨트롤러의 상태가 변할 때마다 tabListener 함수를 실행해라!
    controller.addListener(tabListener);
  }
  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }


  void tabListener(){
    setState(() {
      // 컨트롤러가 현재 가리키는 페이지 번호(index)를 가져와서
      // 내 화면의 상태(index)로 동기화시킨다.
      index = controller.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
            unselectedItemColor: BODY_COLOR,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            type: BottomNavigationBarType.fixed,
            onTap: (int index){
            controller.animateTo(index);
            },
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                label: '홈'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood_outlined),
                  label: '음식'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  label: '주문'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: '프로필'
              ),
            ]
        ),
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
            children: [
              Center(child: Container(child: Text('홈'))),
              Center(child: Container(child: Text('음식'))),
              Center(child: Container(child: Text('주문'))),
              Center(child: Container(child: Text('프로필'))),
            ]
        )
    );
  }
}
