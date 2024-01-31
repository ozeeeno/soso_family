import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late String _question;
  late String _dadAnswer;
  late String _momAnswer;
  late String _daughterAnswer;
  late String _sonAnswer;
  TextEditingController _commentController = TextEditingController();

  // 각 답변에 대한 좋아요 카운트를 저장하는 변수들
  int _dadLikes = 0;
  int _momLikes = 0;
  int _daughterLikes = 0;
  int _sonLikes = 0;

  // 각 답변에 대한 좋아요 여부를 저장하는 변수들
  bool _dadLiked = false;
  bool _momLiked = false;
  bool _daughterLiked = false;
  bool _sonLiked = false;

  @override
  void initState() {
    super.initState();
    // 초기 질문과 답안 설정
    _question = "아빠가 가장 중요하게 생각하는 가족과의 소중한 순간이 무엇일까요?";
    _dadAnswer = "가족들과 함께 저녁 먹으면서 대화를 나누는 시간이 가장 소중해";
    _momAnswer = "최근에 일본 오사카로 다 같이 여행가서 놀았던 순간이 아닐까?";
    _daughterAnswer = "매주 금요일마다 다 같이 나혼자산다 보는 시간일 것 같아 ㅎㅎ";
    _sonAnswer = "아직 답변하지 않았어요..";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 질문'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              _question,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 30),
            buildFamilyMemberAnswer('아빠', _dadAnswer, _dadLikes, _dadLiked),
            buildFamilyMemberAnswer('엄마', _momAnswer, _momLikes, _momLiked),
            buildFamilyMemberAnswer(
                '딸', _daughterAnswer, _daughterLikes, _daughterLiked),
            buildFamilyMemberAnswer('아들', _sonAnswer, _sonLikes, _sonLiked),
            SizedBox(height: 35),
            Text(
              '아들 (나)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: '답변을 작성하세요...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 댓글 제출 및 화면 업데이트
                setState(() {
                  _sonAnswer = _commentController.text;
                });
                print('댓글: $_sonAnswer');
              },
              child: Text('답변 작성'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFamilyMemberAnswer(
      String member, String answer, int likes, bool liked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              member,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: liked ? Colors.red : null,
                  ),
                  onPressed: () {
                    // 좋아요 버튼 누를 때마다 카운트 증가
                    setState(() {
                      if (member == '아빠') {
                        _dadLikes += liked ? -1 : 1;
                        _dadLiked = !_dadLiked;
                      } else if (member == '엄마') {
                        _momLikes += liked ? -1 : 1;
                        _momLiked = !_momLiked;
                      } else if (member == '딸') {
                        _daughterLikes += liked ? -1 : 1;
                        _daughterLiked = !_daughterLiked;
                      } else if (member == '아들') {
                        _sonLikes += liked ? -1 : 1;
                        _sonLiked = !_sonLiked;
                      }
                    });
                  },
                ),
                Text('$likes'),
              ],
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          answer,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
