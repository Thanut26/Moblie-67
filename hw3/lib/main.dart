import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = "0";
  String num1 = "";
  String num2 = "";
  String operator = "";

  void pressNumber(String n) {
    setState(() {
      if (operator.isEmpty) {
        num1 += n;
        display = num1;
      } else {
        num2 += n;
        display = num2;
      }
    });
  }

  void pressOperator(String op) {
    setState(() {
      if (num1.isNotEmpty) operator = op;
    });
  }

  void calculate() {
    setState(() {
      if (num1.isEmpty) return;

      double a = double.parse(num1);
      double b = num2.isEmpty ? 0 : double.parse(num2);
      double result = 0;

      switch (operator) {
        case '+':
          result = a + b;
          break;
        case '-':
          result = a - b;
          break;
        case '*':
          result = a * b;
          break;
        case '/':
          result = a / b;
          break;
        case '^':
          result = pow(a, b).toDouble();
          break;
        case '%':
          result = (a / 100) * b; // A% of B
          break;
      }

      display = result.toString();
      num1 = display;
      num2 = "";
      operator = "";
    });
  }

  void clearAll() {
    setState(() {
      display = "0";
      num1 = "";
      num2 = "";
      operator = "";
    });
  }

  void deleteDigit() {
    setState(() {
      if (operator.isEmpty) {
        if (num1.isNotEmpty) {
          num1 = num1.substring(0, num1.length - 1);
          display = num1.isEmpty ? "0" : num1;
        }
      } else {
        if (num2.isNotEmpty) {
          num2 = num2.substring(0, num2.length - 1);
          display = num2.isEmpty ? "0" : num2;
        }
      }
    });
  }

  void sqrtValue() {
    setState(() {
      if (num1.isNotEmpty) {
        double r = sqrt(double.parse(num1));
        display = r.toString();
        num1 = display;
        num2 = "";
        operator = "";
      }
    });
  }

  Widget calcButton(
    String text, {
    Color bg = Colors.grey,
    Color fg = Colors.white,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(22),
          ),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(fontSize: 22)),
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
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(24),
            child: Text(
              display,
              style: const TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),

          Row(
            children: [
              calcButton(
                "DEL",
                bg: Colors.grey,
                fg: Colors.black,
                onTap: deleteDigit,
              ),
              calcButton(
                "%",
                bg: Colors.grey,
                fg: Colors.black,
                onTap: () => pressOperator('%'),
              ),
              calcButton(
                "^",
                bg: Colors.grey,
                fg: Colors.black,
                onTap: () => pressOperator('^'),
              ),
              calcButton(
                "/",
                bg: Colors.orange,
                onTap: () => pressOperator('/'),
              ),
            ],
          ),

          Row(
            children: [
              calcButton("7", onTap: () => pressNumber('7')),
              calcButton("8", onTap: () => pressNumber('8')),
              calcButton("9", onTap: () => pressNumber('9')),
              calcButton(
                "*",
                bg: Colors.orange,
                onTap: () => pressOperator('*'),
              ),
            ],
          ),

          Row(
            children: [
              calcButton("4", onTap: () => pressNumber('4')),
              calcButton("5", onTap: () => pressNumber('5')),
              calcButton("6", onTap: () => pressNumber('6')),
              calcButton(
                "-",
                bg: Colors.orange,
                onTap: () => pressOperator('-'),
              ),
            ],
          ),

          Row(
            children: [
              calcButton("1", onTap: () => pressNumber('1')),
              calcButton("2", onTap: () => pressNumber('2')),
              calcButton("3", onTap: () => pressNumber('3')),
              calcButton(
                "+",
                bg: Colors.orange,
                onTap: () => pressOperator('+'),
              ),
            ],
          ),

          Row(
            children: [
              calcButton(
                "C",
                bg: Colors.grey,
                fg: Colors.black,
                onTap: clearAll,
              ),
              calcButton("0", onTap: () => pressNumber('0')),
              calcButton(
                "√",
                bg: Colors.grey,
                fg: Colors.black,
                onTap: sqrtValue,
              ),
              calcButton("=", bg: Colors.orange, onTap: calculate),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
