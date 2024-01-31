import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late String _month;
  late String _dadAIreport;
  late String _momAIreport;
  late String _daughterAIreport;
  late String _sonAIreport;

  @override
  void initState() {
    super.initState();
    // 초기 질문과 답안 설정
    _month = "2023년 12월";
    _dadAIreport = "papa";
    _momAIreport = "mama";
    _daughterAIreport = "daughter";
    _sonAIreport = "son";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이 달의 리포트'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(_month,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
            ),
            SizedBox(height: 20),
            Text(
              "AI가 우리 가족에 대해 정리해줬어요.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            AIFamilyMemberAnswer('아빠', _dadAIreport),
            AIFamilyMemberAnswer('엄마', _momAIreport),
            AIFamilyMemberAnswer('딸', _daughterAIreport),
            AIFamilyMemberAnswer('아들', _sonAIreport),
          ],
        ),
      ),
    );
  }

  Widget AIFamilyMemberAnswer(String member, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          answer,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
