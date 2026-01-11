import 'dart:math';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String userNumber;
  final int money;

  const ResultPage({super.key, required this.userNumber, required this.money});

  String randomNumber() {
    Random r = Random();
    return '${r.nextInt(10)}${r.nextInt(10)}${r.nextInt(10)}';
  }

  @override
  Widget build(BuildContext context) {
    String luckyNumber = randomNumber();

    //เลขรางวัลพิเศษที่กำหนด
    List<String> specialNumbers = ['090', '098', '123'];

    //เงื่อนไขถูกรางวัล
    bool isWin =
        userNumber == luckyNumber || specialNumbers.contains(userNumber);

    int reward = isWin ? money * 100 : 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('ผลการตรวจรางวัล'), centerTitle: true),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('เลขที่คุณซื้อ : $userNumber'),
                Text('จำนวนเงิน : $money บาท'),

                const Divider(height: 30),

                Text(
                  'เลขที่ออก : $luckyNumber',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                if (specialNumbers.contains(userNumber))
                  const Text(
                    'คุณถูกรางวัลเลขพิเศษ',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                const SizedBox(height: 10),

                isWin
                    ? Column(
                        children: [
                          const Text(
                            'ยินดีด้วย คุณถูกรางวัล',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('รับเงินรางวัล $reward บาท'),
                        ],
                      )
                    : const Text(
                        'เสียใจด้วย คุณไม่ถูกรางวัล',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('กลับหน้าหลัก'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
