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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int oScore = 0;
  int xScore = 0;
  bool oTurn = true;
  var displayXO = List.filled(9, '', growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 73, right: 45),
                  child: Column(children: <Widget>[
                    const Text(
                      'Player O',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    Text(
                      oScore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 73),
                  child: Column(children: <Widget>[
                    const Text(
                      'Player X',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    Text(
                      xScore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  ]),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        displayXO[index],
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 9,
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (displayXO[index] == '') {
        if (oTurn) {
          displayXO[index] = 'o';
          _checkWinner();
          oTurn = !oTurn;
        } else {
          displayXO[index] = 'x';
          _checkWinner();
          oTurn = !oTurn;
        }
      }
    });
  }

  void _checkWinner() {
    // In line on 1st row OR on 1st column OR falling diagonal
    if ((displayXO[0] == displayXO[1] &&
            displayXO[0] == displayXO[2] &&
            displayXO[0] != '') ||
        (displayXO[0] == displayXO[3] &&
            displayXO[0] == displayXO[6] &&
            displayXO[0] != '') ||
        (displayXO[0] == displayXO[4] &&
            displayXO[0] == displayXO[8] &&
            displayXO[0] != '')) {
      _showDialog(displayXO[0]);
    }
    // In line on 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      _showDialog(displayXO[3]);
    }

    // In line on 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      _showDialog(displayXO[6]);
    }

    // In line on 2st column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      _showDialog(displayXO[1]);
    }

    // In line on 3st column OR on rising diagonal
    if ((displayXO[2] == displayXO[5] &&
            displayXO[2] == displayXO[8] &&
            displayXO[2] != '') ||
        (displayXO[2] == displayXO[4] &&
            displayXO[2] == displayXO[6] &&
            displayXO[2] != '')) {
      _showDialog(displayXO[2]);
    }
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner.toUpperCase() + ' WON'),
            actions: [
              TextButton(
                child: Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    if (winner == 'o') {
      oScore += 1;
    } else if (winner == 'x') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < displayXO.length; i++) {
        displayXO[i] = '';
      }
    });
  }
}
