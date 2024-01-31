import 'package:flutter/material.dart';

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
    // Simulate API call and get reports
    // Replace this with your actual API call
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay

    setState(() {
      // Update reports based on API response
      _dadAIreport = "AI-generated report for 아빠";
      _momAIreport = "AI-generated report for 엄마";
      _daughterAIreport = "AI-generated report for 딸";
      _sonAIreport = "AI-generated report for 아들";
      _isButtonVisible = false; // Hide the button
      _isActivityButtonVisible = true;
    });
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
