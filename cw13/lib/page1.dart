import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'BMI Calculator & Firebase',
          style: TextStyle(color: Colors.white),
        ), // Text
      ), // AppBar
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('userData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      data['name'] ?? 'No Name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // แสดงค่าน้ำหนัก ส่วนสูง และ BMI
                    subtitle: Text(
                      'Weight: ${data['weight']} kg, Height: ${data['height']} cm\nBMI: ${data['BMI']}',
                    ),
                    isThreeLine: true, // อนุญาตให้ subtitle มี 2 บรรทัด
                    leading: const Icon(Icons.person, size: 40),
                    // เอาเงื่อนไข admin ออก ให้แสดงปุ่มแก้ไข/ลบ ตลอด
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              doEdit(document, data);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              doDel(document.id);
                            },
                          ),
                        ],
                      ),
                    ),
                    tileColor: Colors.amberAccent.shade100,
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          doAdd();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void doAdd() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add BMI Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name (ชื่อ)'),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (น้ำหนัก kg)',
                ),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (ส่วนสูง cm)',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // คำนวณ BMI
                double weight = double.tryParse(weightController.text) ?? 0;
                double heightCm = double.tryParse(heightController.text) ?? 0;
                double bmi = 0;

                if (heightCm > 0) {
                  double heightM = heightCm / 100; // แปลงเป็นเมตร
                  bmi = weight / (heightM * heightM);
                }

                // ปัดเศษทศนิยม 2 ตำแหน่ง
                double finalBmi = double.parse(bmi.toStringAsFixed(2));

                final FirebaseFirestore firestore = FirebaseFirestore.instance;
                final CollectionReference mainCollection = firestore.collection(
                  'userData',
                );

                mainCollection.add({
                  'name': nameController.text,
                  'weight': weight,
                  'height': heightCm,
                  'BMI': finalBmi,
                });

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void doEdit(DocumentSnapshot document, Map<String, dynamic> data) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();

    nameController.text = data['name'].toString();
    weightController.text = data['weight'].toString();
    heightController.text = data['height'].toString();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit BMI Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name (ชื่อ)'),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (น้ำหนัก kg)',
                ),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (ส่วนสูง cm)',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Save Data'),
                      content: const Text('Are you sure you want to save?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context); // ปิดหน้าต่าง Confirm

                            // คำนวณ BMI ใหม่หลังแก้ไข
                            double weight =
                                double.tryParse(weightController.text) ?? 0;
                            double heightCm =
                                double.tryParse(heightController.text) ?? 0;
                            double bmi = 0;

                            if (heightCm > 0) {
                              double heightM = heightCm / 100;
                              bmi = weight / (heightM * heightM);
                            }

                            double finalBmi = double.parse(
                              bmi.toStringAsFixed(2),
                            );

                            final FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
                            final CollectionReference mainCollection = firestore
                                .collection('userData');

                            await mainCollection.doc(document.id).update({
                              'name': nameController.text,
                              'weight': weight,
                              'height': heightCm,
                              'BMI': finalBmi,
                            });
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    Navigator.pop(context);
  }

  void doDel(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final FirebaseFirestore firestore = FirebaseFirestore.instance;
                final CollectionReference mainCollection = firestore.collection(
                  'userData',
                );

                await mainCollection.doc(id).delete();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
