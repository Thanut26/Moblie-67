import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodMenuPage(),
    );
  }
}

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({super.key});

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  List<String> menuList = [];
  int menuCount = 1;

  void addMenu() {
    setState(() {
      menuList.add("เมนูที่ $menuCount");
      menuCount++;
    });
  }

  void removeMenu() {
    if (menuList.isNotEmpty) {
      setState(() {
        menuList.removeLast();
        menuCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Menu"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.restaurant,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(menuList[index], style: const TextStyle(fontSize: 20)),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: addMenu,
            backgroundColor: Colors.deepOrange,
            icon: const Icon(Icons.add),
            label: const Text("เพิ่มเมนู"),
          ),
          const SizedBox(width: 12),
          FloatingActionButton.extended(
            onPressed: removeMenu,
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.remove),
            label: const Text("ลบเมนู"),
          ),
        ],
      ),
    );
  }
}
