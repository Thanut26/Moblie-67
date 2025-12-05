import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorUI(),
    );
  }
}

class CalculatorUI extends StatefulWidget {
  const CalculatorUI({super.key});

  @override
  State<CalculatorUI> createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  String display = "0";

  Widget buildButton(
    String text, {
    Color? color = const Color(0xFF333333),
    double flex = 1,
  }) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(text == "0" ? 50 : 100),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 22,
              horizontal: text == "0" ? 60 : 0,
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              display,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          // Buttons
          Column(
            children: [
              Row(
                children: [
                  buildButton("AC", color: Colors.grey.shade500),
                  buildButton("±", color: Colors.grey.shade500),
                  buildButton("%", color: Colors.grey.shade500),
                  buildButton("÷", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("×", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", flex: 2),
                  buildButton(".", color: Colors.grey.shade600),
                  buildButton("=", color: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
