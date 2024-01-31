import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late String _month;
  late String _dadAIreport;
  late String _momAIreport;
  late String _daughterAIreport;
  late String _sonAIreport;
  bool _isButtonVisible = true;
  bool _isActivityButtonVisible = false;

  @override
  void initState() {
    super.initState();
    // 초기 질문과 답안 설정
    _month = "2023년 12월";
    _dadAIreport = "";
    _momAIreport = "";
    _daughterAIreport = "";
    _sonAIreport = "";
  }

  // Function to simulate API call and update reports
  Future<void> generateAIReport() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/report'));
    if (response.statusCode == 200) {
      // then parse the JSON.
      print("report.dart");
      print(utf8.decode(response.bodyBytes));
      setState(() {
        // Update reports based on API response
        _dadAIreport =
            "아빠는 자연과 모험을 즐기며, 낚시와 야외 활동에 열중해. 역사와 문화에도 관심이 많아 유럽 여행을 선호하며, 현지 음식을 맛보는 것을 즐겨. 여행 중에는 휴식과 풍경 감상 뿐만 아니라 현지 식재료를 활용한 식사도 크게 즐기며 여행의 다양한 측면을 경험해.";
        _momAIreport = utf8.decode(response.bodyBytes);
        _daughterAIreport =
            "최근 딸은 친구들과의 갈등으로 마음이 상하기 시작했어. 어떤 일이 있었는지는 정확히 모르겠지만, 아마도 그들과의 관계에서 갈등이 생겼거나 이해하지 못할 일이 있었던 것 같아. 딸이 좋아하는 떡볶이를 함께 즐기며 마음을 나누면 더욱 따뜻한 소통이 될 거야.";
        _sonAIreport =
            "아들은 학생이지만 게임에 대한 큰 관심을 가지고 있어. 이러한 취향은 그의 성장과 미래에 관련 분야에서의 열정과 연결돼, 게임 개발이나 디자인 분야에서의 꿈을 형성하고 있어.";
        _isButtonVisible = false; // Hide the button
        _isActivityButtonVisible = true;
      });
      // return OpenAIDialogue.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Dialogue.');
    }
    // await Future.delayed(const Duration(seconds: 2)); // Simulating a delay
  }

  void recommendActivities() {
    setState(() {
      _isActivityButtonVisible = true; // 버튼 숨기기
      // TODO: 실제 활동 추천 로직 구현
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이 달의 리포트'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  _month,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isButtonVisible)
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger AI report generation
                        generateAIReport();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'AI 리포트 생성하기',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              AIFamilyMemberAnswer('아빠', _dadAIreport),
              AIFamilyMemberAnswer('엄마', _momAIreport),
              AIFamilyMemberAnswer('딸', _daughterAIreport),
              AIFamilyMemberAnswer('아들', _sonAIreport),
              if (_isActivityButtonVisible)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: recommendActivities,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      '우리 가족에게 맞는 활동 추천 받기',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AIFamilyMemberAnswer(String member, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
