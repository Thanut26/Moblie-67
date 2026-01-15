import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const GradeForm(),
    );
  }
}

class GradeForm extends StatefulWidget {
  const GradeForm({super.key});

  @override
  State<GradeForm> createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  // Controller สำหรับรับค่าจากช่องกรอก
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _collectScore = TextEditingController();
  final TextEditingController _midScore = TextEditingController();
  final TextEditingController _finalScore = TextEditingController();

  String _major = 'INE'; // ค่าเริ่มต้น Radio
  String _selectedSubject =
      'INE-101 Computer Programming'; // ค่าเริ่มต้น Dropdown

  // ตัวแปรสำหรับแสดงผลลัพธ์
  String resName = "";
  double resCollect = 0, resMid = 0, resFinal = 0, resTotal = 0;
  String resGrade = "-";
  bool showResult = false;

  // รายชื่อวิชาสำหรับ Dropdown
  final List<String> subjects = [
    'INE-101 Computer Programming',
    'INE-102 Web Technology',
    'INET-201 Network Administration',
    'INET-202 Cloud Computing',
  ];

  void calculateGrade() {
    setState(() {
      resName = _nameController.text;
      resCollect = double.tryParse(_collectScore.text) ?? 0;
      resMid = double.tryParse(_midScore.text) ?? 0;
      resFinal = double.tryParse(_finalScore.text) ?? 0;
      resTotal = resCollect + resMid + resFinal;

      if (resTotal >= 80)
        resGrade = "A";
      else if (resTotal >= 70)
        resGrade = "B";
      else if (resTotal >= 60)
        resGrade = "C";
      else if (resTotal >= 50)
        resGrade = "D";
      else
        resGrade = "F";

      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grade Calculator Pro',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Input Section Card ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ข้อมูลนักศึกษา",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const Divider(),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อ - นามสกุล',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("สาขาวิชา: "),
                        Radio(
                          value: 'INE',
                          groupValue: _major,
                          onChanged: (val) => setState(() => _major = val!),
                        ),
                        const Text("INE"),
                        Radio(
                          value: 'INET',
                          groupValue: _major,
                          onChanged: (val) => setState(() => _major = val!),
                        ),
                        const Text("INET"),
                      ],
                    ),
                    DropdownButtonFormField(
                      value: _selectedSubject,
                      decoration: const InputDecoration(
                        labelText: 'เลือกรายวิชา',
                      ),
                      items: subjects
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedSubject = val!),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "คะแนน",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(child: scoreField(_collectScore, "คะแนนเก็บ")),
                        const SizedBox(width: 10),
                        Expanded(child: scoreField(_midScore, "กลางภาค")),
                        const SizedBox(width: 10),
                        Expanded(child: scoreField(_finalScore, "ปลายภาค")),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: calculateGrade,
                        icon: const Icon(Icons.calculate),
                        label: const Text("คำนวณเกรด"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Result Section Card ---
            if (showResult)
              Card(
                color: Colors.indigo.shade50,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.indigoAccent),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "📊 ผลการเรียน",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      resultRow("ชื่อ-นามสกุล:", resName),
                      resultRow(
                        "คะแนนรวม:",
                        "${resTotal.toStringAsFixed(2)} / 100",
                      ),
                      const Divider(),
                      Text(
                        "เกรดที่ได้",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      Text(
                        resGrade,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: resGrade == "F" ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget scoreField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget resultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
