import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController controller = TextEditingController();

  Future<void> writeToCache(String text) async {
    final cache = await SharedPreferences.getInstance();
    await cache.setString('myKey', text);
  }

  Future<String> readFromCache() async {
    final cache = await SharedPreferences.getInstance();
    final text = cache.getString('myKey');
    if (text != null) {
      return text;
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              onChanged: (value) {
                writeToCache(value);
              },
            ),
            const SizedBox(height: 50),
            FutureBuilder(
              future: readFromCache(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text(snapshot.data!);
                } else {
                  return const Text('Hozircha o\'qib ulgurmadi');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
