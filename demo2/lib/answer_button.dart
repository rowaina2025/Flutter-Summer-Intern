import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.answerText, required this.onTap});

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
                ),
                backgroundColor: const Color.fromARGB(255, 61, 5, 71),
                foregroundColor: Colors.white,
              ), 
              child: Text(
                answerText,
                textAlign: TextAlign.center,
              ),
            );
  }
}