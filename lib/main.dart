import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  Color _buttonColor = const Color.fromARGB(255, 173, 187, 199);

  void _increment() {
    setState(() {
      _counter++;
      _updateButtonColor();
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
      _updateButtonColor();
    });
  }


  void _reset() {
    setState(() {
      _counter = 0;
      _updateButtonColor();
    });
  }

  void _updateButtonColor() {
    if (_counter % 10 == 0 && _counter != 0) {
      _buttonColor = const Color.fromARGB(255, 175, 76, 125);
    } else {
      _buttonColor = const Color.fromARGB(255, 10, 2, 82);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 174, 232),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrement,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: _buttonColor,
                  ),
                  child: const Text(
                    '−',
                    style: TextStyle(fontSize: 32, color: Color.fromARGB(255, 196, 133, 136)),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _increment,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: _buttonColor,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 32, color: Color.fromARGB(255, 144, 92, 21)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: FloatingActionButton(
                  onPressed: _reset,
                  backgroundColor: Colors.red,
                  child: const Text('X', style: TextStyle(fontSize: 24)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
