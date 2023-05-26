import 'package:flutter/material.dart';

class TimeOut extends StatelessWidget {
  final VoidCallback stopAudio;

  const TimeOut({required this.stopAudio, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Finished'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Timer Finished',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'The timer has reached zero.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                stopAudio(); // Call the stopAudio function
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
