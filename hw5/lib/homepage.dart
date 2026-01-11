import 'package:flutter/material.dart';
import 'result.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController digit1 = TextEditingController();
  final TextEditingController digit2 = TextEditingController();
  final TextEditingController digit3 = TextEditingController();
  final TextEditingController moneyController = TextEditingController();

  void checkResult() {
    String userNumber = digit1.text + digit2.text + digit3.text;
    int money = int.tryParse(moneyController.text) ?? 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(userNumber: userNumber, money: money),
      ),
    );
  }

  Widget numberBox(TextEditingController controller) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.deepPurple.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Lottery N3'), centerTitle: true),
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
                const Text(
                  'เลือกเลขท้าย 3 หลัก',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    numberBox(digit1),
                    const SizedBox(width: 10),
                    numberBox(digit2),
                    const SizedBox(width: 10),
                    numberBox(digit3),
                  ],
                ),

                const SizedBox(height: 25),
                const Text(
                  'จำนวนเงินที่ต้องการซื้อ',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: moneyController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixText: 'บาท',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: checkResult,
                  icon: const Icon(Icons.search),
                  label: const Text(
                    'ตรวจรางวัล',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
