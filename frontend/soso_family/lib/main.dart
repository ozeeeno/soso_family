import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:soso_family/pages/question.dart';
import 'package:soso_family/pages/events.dart';
import 'package:soso_family/pages/rank.dart';
import 'package:soso_family/pages/report.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoSo Family',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스

  final _pages = [
    const CalendarPage(),
    const QuestionPage(),
    const RankPage(),
    const ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.cast<Widget>(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 고정된 타입으로 설정
        selectedFontSize: 12.0, // 선택된 항목의 폰트 크기 설정
        unselectedFontSize: 12.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // BottomNavigationBar 배경색 설정
        backgroundColor: Colors.blue,
        // 선택된 탭의 아이템 색상
        selectedItemColor: Colors.white,
        // 선택되지 않은 탭의 아이템 색상
        unselectedItemColor: Colors.white70,
        // 탭 아이템들
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: '오늘의질문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: '랭킹보드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: '리포트',
          ),
        ],
      ),
    );
  }
}
