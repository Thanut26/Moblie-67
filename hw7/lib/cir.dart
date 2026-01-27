import 'package:flutter/material.dart';
import 'dart:math';

class CirPage extends StatefulWidget {
  final bool isArea;
  const CirPage({super.key, required this.isArea});

  @override
  State<CirPage> createState() => _CirPageState();
}

class _CirPageState extends State<CirPage> {
  final rCtrl = TextEditingController();
  double result = 0;

  void calculate() {
    double r = double.tryParse(rCtrl.text) ?? 0;

    setState(() {
      result = widget.isArea ? pi * r * r : (4 / 3) * pi * r * r * r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Circle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            input(rCtrl, "Radius"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: Text(
                widget.isArea ? "Calculate Area" : "Calculate Volume",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Result = $result",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget input(TextEditingController ctrl, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
