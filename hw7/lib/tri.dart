import 'package:flutter/material.dart';

class TriPage extends StatefulWidget {
  final bool isArea;
  const TriPage({super.key, required this.isArea});

  @override
  State<TriPage> createState() => _TriPageState();
}

class _TriPageState extends State<TriPage> {
  final bCtrl = TextEditingController();
  final hCtrl = TextEditingController();
  double result = 0;

  void calculate() {
    double b = double.tryParse(bCtrl.text) ?? 0;
    double h = double.tryParse(hCtrl.text) ?? 0;

    setState(() {
      result = widget.isArea ? 0.5 * b * h : 0.5 * b * h * h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Triangle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            input(bCtrl, "Base"),
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
