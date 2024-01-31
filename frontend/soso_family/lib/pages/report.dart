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
  bool _isButtonVisible = true;

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
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay

    setState(() {
      // Update reports based on API response
      _dadAIreport = "AI-generated report for 아빠";
      _momAIreport = "AI-generated report for 엄마";
      _daughterAIreport = "AI-generated report for 딸";
      _sonAIreport = "AI-generated report for 아들";
      _isButtonVisible = false; // Hide the button
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이 달의 리포트'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  _month,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'AI 리포트 생성하기',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 30),
              AIFamilyMemberAnswer('아빠', _dadAIreport),
              AIFamilyMemberAnswer('엄마', _momAIreport),
              AIFamilyMemberAnswer('딸', _daughterAIreport),
              AIFamilyMemberAnswer('아들', _sonAIreport),
            ],
          ),
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
