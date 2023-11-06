import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Player {
  int playerNumber;
  int score;
  int lastRoll;

  Player(this.playerNumber, this.score, this.lastRoll);
}

class DiceApp extends StatefulWidget {
  @override
  _DiceAppState createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  List<Player> players = List<Player>.generate(4, (i) => Player(i + 1, 0, 0));
  int currentPlayer = 0;
  int diceValue = 1;
  bool extraTurn = false;

  void rollDice() {
    setState(() {
      diceValue = Random().nextInt(6) + 1;
      players[currentPlayer].lastRoll = diceValue;
      if (diceValue == 6) {
        extraTurn = true;
        players[currentPlayer].score += diceValue; // Increment the score
      } else {
        extraTurn = false;
        players[currentPlayer].score += diceValue; // Increment the score
        currentPlayer = (currentPlayer + 1) % 4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roll App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Player ${players[currentPlayer].playerNumber}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Player ${players[i].playerNumber}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Score: ${players[i].score}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        if (players[i].lastRoll != 0)
                          Image.asset(
                            'assets/dice_${players[i].lastRoll}.png',
                            width: 50.0,
                            height: 50.0,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/dice_$diceValue.png',
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: rollDice,
              child: Text('Roll the Dice'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiceApp(),
    );
  }
}