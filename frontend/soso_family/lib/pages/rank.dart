import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  late final String _month;
  List<FamilyMember> familyMembers = [];

  @override
  void initState() {
    super.initState();
    _month = "2023년 12월";

    familyMembers = [
      FamilyMember(name: '아빠', hearts: 5),
      FamilyMember(name: '엄마', hearts: 3),
      FamilyMember(name: '딸', hearts: 4),
      FamilyMember(name: '아들', hearts: 2),
    ];

    familyMembers.sort((a, b) => b.hearts.compareTo(a.hearts));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이번 달 우리 가족 랭킹'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(_month,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            const SizedBox(height: 20),
            const Text("마음에 쏙 드는 답변을 내놓은 사람은 누구일까요!",
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  return FamilyMemberWidget(
                      member: familyMembers[index], rank: index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyMember {
  String name;
  int hearts;

  FamilyMember({required this.name, required this.hearts});
}

class FamilyMemberWidget extends StatelessWidget {
  final FamilyMember member;
  final int rank;

  const FamilyMemberWidget({Key? key, required this.member, required this.rank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildRankIcon(rank),
                const SizedBox(width: 10),
                Text(
                  member.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${member.hearts} hearts ',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.favorite, color: Colors.red, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankIcon(int rank) {
    IconData iconData;
    switch (rank) {
      case 1:
        iconData = Icons.looks_one;
        break;
      case 2:
        iconData = Icons.looks_two;
        break;
      case 3:
        iconData = Icons.looks_3;
        break;
      default:
        iconData = Icons.looks_4;
        break;
    }
    return Icon(iconData, color: Colors.amber, size: 24);
  }
}
