import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // เอาป้าย Debug ออก
      title: 'List Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'List Example'),
    );
  }
}

// Data Class ตามสไลด์หน้า 3 (source: 122)
class data {
  late int id;
  late String name;
  late DateTime t;

  data(this.id, this.name, this.t);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ตัวแปร State ตามสไลด์
  String txt = ''; // (source: 196, 107)
  List<data> mylist = []; // (source: 108)
  int img = 1; // ตัวแปรเก็บค่า Radio ที่เลือก (source: 139)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วนเลือก Icon (Radio Buttons)
            // สร้าง Row เพื่อจัดเรียงแนวนอนเหมือนใน Screenshot
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  radioItem(1, 'assets/images/ig.png'),
                  radioItem(2, 'assets/images/line.png'),
                  radioItem(3, 'assets/images/avenger.png'),
                  radioItem(4, 'assets/images/marvel.jpeg'),
                ],
              ),
            ),

            // ช่องกรอกข้อความ (source: 191)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter text..."),
              ),
            ),

            // ปุ่ม Add Item (source: 192)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  txt = "Add item Success";
                  // เพิ่มข้อมูลลงใน List (source: 197)
                  // หมายเหตุ: ตามโค้ดในสไลด์ ใช้ตัวแปร img เป็น id
                  mylist.add(data(img, '1', DateTime.now()));
                });
              },
              child: const Text('Add Item'),
            ),

            // ข้อความแสดงสถานะ (source: 200)
            Text(
              txt,
              textScaleFactor: 1.5, // ปรับขนาดให้อ่านง่ายขึ้น (สไลด์ใช้ 2)
              style: const TextStyle(color: Colors.black54),
            ),

            // พื้นที่แสดงรายการ (ListView) (source: 206)
            SizedBox(
              width: double.infinity,
              height: 550,
              child: ListView.builder(
                itemCount: mylist.length, // (source: 210)
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      elevation: 5,
                      // ขอบมนกลม (source: 218)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      // สีรุ้งตาม Index (source: 220)
                      color: Colors.primaries[index % Colors.primaries.length],
                      child: ListTile(
                        // รูป Rocket ด้านหน้า (source: 222)
                        leading: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/images/rocket.png',
                          ),
                        ),
                        // ข้อความ Title (source: 227)
                        title: Text(
                          'Title Text (${mylist[index].id})',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // ข้อความ Subtitle (วันที่) (source: 228)
                        subtitle: Text(mylist[index].t.toString()),
                        // ปุ่มลบด้านหลัง (Trailing)
                        trailing: const Icon(Icons.delete_rounded),
                        // กดเพื่อลบ (source: 229)
                        onTap: () {
                          setState(() {
                            txt = "Title Text ($index) is remove";
                            mylist.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันช่วยสร้าง Widget Radio + รูปภาพ เพื่อลดความซ้ำซ้อน
  Widget radioItem(int value, String assetPath) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: img,
          onChanged: (int? v) {
            setState(() {
              img = v!;
            });
          },
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(assetPath),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 10), // เว้นระยะห่างนิดหน่อย
      ],
    );
  }
}
