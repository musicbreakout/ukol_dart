import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Můj To-Do List',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  void _addTask() {
    String text = _controller.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zadej prosím úkol')),
      );
      return;
    }

    setState(() {
      _tasks.add({'text': text, 'done': false});
      _controller.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Úkol přidán')),
    );
  }

  void _deleteTask(int index) {
    final deletedTask = _tasks[index]['text'];
    setState(() {
      _tasks.removeAt(index);
    });
    debugPrint('Deleted: $deletedTask');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Úkol smazán')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Můj To-Do List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Můj To-Do List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse rutrum dolor a fringilla feugiat',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse rutrum dolor a fringilla feugiat. Mauris ut dapibus enim, non ultrices massa.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // TextField + tlačítko
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Zadej úkol…',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Přidat'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Scrollovatelný seznam úkolů
            Expanded(
              child: ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 95, 32, 32),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: task['done'],
                          onChanged: (value) {
                            setState(() {
                              task['done'] = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            task['text'],
                            style: TextStyle(
                              fontSize: 16,
                              decoration: task['done']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.redAccent,
                          onPressed: () => _deleteTask(index),
                        ),
                      ],
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
}