import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [
//
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getTxt(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                handle_answer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                handle_answer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(children: scoreKeeper)
      ],
    );
  }

  void handle_answer(bool user_answer) {
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(context: context, title: "ended", desc: "quiz ended.").show();
        quizBrain.reset();
        scoreKeeper.clear();
        return;
      }
      if (quizBrain.getAns() && user_answer ||
          !quizBrain.getAns() && !user_answer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
//
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      ;

//                  scoreKeeper.add(value)
      quizBrain.nextQst();
    });
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
