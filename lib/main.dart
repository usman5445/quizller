// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'quiz_controller.dart';

void main() {
  runApp(MaterialApp(
    home: QuizApp(),
    theme: ThemeData(useMaterial3: true),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> score = [];
  QuizController quizController = QuizController();

  void checkAnswer(
    bool userAnswer,
  ) {
    final isCorrect = quizController.getAnswer() == userAnswer;
    bool isNextQuestion = true;
    setState(() {
      score.add(Icon(
        isCorrect ? Icons.check : Icons.close,
        color: isCorrect ? Colors.green : Colors.red,
      ));
      isNextQuestion = quizController.nextQuestion();
    });

    if (isNextQuestion == false) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey[800],
              title: Text(
                'Hurrey! You have compleated the quiz.',
                style: TextStyle(color: Colors.white),
              ),
              content: Wrap(
                alignment: WrapAlignment.center,
                children: score,
              ),
              icon: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quizController.reset();
                      score.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    quizController.getQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: score,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(true),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    textStyle: MaterialStatePropertyAll(
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: Text('True'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(false),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    textStyle: MaterialStatePropertyAll(
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: Text('False'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
