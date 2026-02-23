import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await DatabaseHelper.instance.queryAllUsers();
    setState(() {
      users = data.map((e) => User.fromMap(e)).toList();
    });
  }

  Future<void> addUser() async {
    if (usernameController.text.isEmpty || emailController.text.isEmpty) return;

    await DatabaseHelper.instance.insertUser(
      User(
        username: usernameController.text,
        email: emailController.text,
      ),
    );

    usernameController.clear();
    emailController.clear();
    loadUsers();
  }

  Future<void> updateUser(User user) async {
    await DatabaseHelper.instance.updateUser(user);
    loadUsers();
  }

  Future<void> deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    loadUsers();
  }

  Future<void> deleteAllUsers() async {
    await DatabaseHelper.instance.deleteAllUsers();
    loadUsers();
  }

  void showEditDialog(User user) {
    usernameController.text = user.username;
    emailController.text = user.email;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await updateUser(
                User(
                  id: user.id,
                  username: usernameController.text,
                  email: emailController.text,
                ),
              );
              usernameController.clear();
              emailController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: deleteAllUsers,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addUser,
                  child: const Text('Add User'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.username),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showEditDialog(user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteUser(user.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
