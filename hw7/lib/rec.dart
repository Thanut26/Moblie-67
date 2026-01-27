import 'package:flutter/material.dart';

class RecPage extends StatefulWidget {
  final bool isArea;
  const RecPage({super.key, required this.isArea});

  @override
  State<RecPage> createState() => _RecPageState();
}

class _RecPageState extends State<RecPage> {
  final wCtrl = TextEditingController();
  final hCtrl = TextEditingController();
  double result = 0;

  void calculate() {
    double w = double.tryParse(wCtrl.text) ?? 0;
    double h = double.tryParse(hCtrl.text) ?? 0;

    setState(() {
      result = widget.isArea ? w * h : w * h * h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rectangle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            input(wCtrl, "Width"),
            input(hCtrl, "Height"),
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
