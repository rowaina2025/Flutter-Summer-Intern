import 'package:demo2/data/questions.dart';
import 'package:demo2/questions_summary.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for(var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
        }
      );
    }

    return summary;
  } 

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['correct_answer'] == data['user_answer'];
    }).length;


    return SizedBox(
      width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40), 
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You answered $numCorrectQuestions questions out of $numTotalQuestions questions corrctly'
              ),
              const SizedBox(
                height: 30,
              ),
              QuestionsSummary(
                getSummaryData()
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Result Quiz!'),
              )
            ],
          ),
        ),
    );
  }

}