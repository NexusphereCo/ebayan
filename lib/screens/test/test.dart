import 'dart:math';

import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/widgets/card_sphere.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eBayan',
      theme: EBTheme.data(),
      home: const TestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  int wordCount = 10; // Initial word count

  String generateRandomWords(int count) {
    final random = Random();
    const letters = 'abcdefghijklmnopqrstuvwxyz';

    final List<String> words = List.generate(count, (index) {
      final wordLength = random.nextInt(10) + 1;
      final word = List.generate(wordLength, (i) {
        final letterIndex = random.nextInt(letters.length);
        return letters[letterIndex];
      }).join('');
      return word;
    });
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final randomWords = generateRandomWords(wordCount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 300,
              child: EBTypography.text(
                text: randomWords,
                maxLines: 2,
              ),
            ),
            SizedBox(
              width: 300,
              child: Text(
                randomWords,
              ),
            ),
            const SphereCard(),
            Slider(
              value: wordCount.toDouble(),
              min: 1,
              max: 50,
              onChanged: (value) {
                setState(() {
                  wordCount = value.toInt();
                });
              },
            ),
            Text('Number of Words: $wordCount'),
          ],
        ),
      ),
    );
  }
}
