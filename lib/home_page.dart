import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tictactoe/o.dart';
import 'package:tictactoe/x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scafoldKey = new GlobalKey<ScaffoldState>();

  bool _isEnabled = true;

  AssetImage cross = AssetImage("assets/images/cross.png");
  AssetImage circle = AssetImage("assets/images/circle.png");
  AssetImage edit = AssetImage("assets/images/edit.png");

  int crossWin = 0;
  int circleWin = 0;
  int draw = 0;

  List<String> gameState;

  bool isCross = true;
  bool gameEnd = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
    });
  }

  Widget getImage(String value) {
//    if (!_isEnabled) {
//      return Image(image: edit);
//    }

    switch (value) {
      case ('empty'):
        return Image(image: edit);
        break;
      case ('cross'):
        return X(50, 10);
        break;
      case ('circle'):
        return O(50, Colors.green);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
        backgroundColor: Color(0xFF1C1C1C),
//      appBar: AppBar(
//        title: Text(
//          'Tic Tac Toe',
//          style: TextStyle(color: Colors.white),
//        ),
//        backgroundColor: Color(0xFF1C1C1C),
//      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
              height: 100.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Cross',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${crossWin}',
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Circle',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${circleWin}',
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Draw',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${draw}',
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                itemCount: gameState.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: MaterialButton(
                    onPressed: () => playGame(i),
                    child: getImage(gameState[i]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, right: 20.0, bottom: 50.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(Icons.refresh),
                        onPressed: () => newGame(),
                        backgroundColor: Colors.blueAccent,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'New Game',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.play_arrow),
                        onPressed: () => resetGame(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Play again',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: 0, // this will be set when a new tab is tapped
//        items: [
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.home),
//            title: new Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.mail),
//            title: new Text('Messages'),
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.person), title: Text('Profile'))
//        ],
//      ),
      ),
    );
  }

  playGame(int index) {
    if (gameState[index] == "empty") {
      setState(() {
        if (isCross) {
          gameState[index] = "cross";
        } else {
          gameState[index] = "circle";
        }
        isCross = !isCross;
        checkWin();
      });
    }
  }

  checkWin() {
    if (!gameEnd) {
      if ((gameState[0]) != 'empty' &&
          (gameState[0] == gameState[1]) &&
          (gameState[1] == gameState[2])) {
        setState(() {
          showWiner(gameState[0]);
          markPoints(gameState[0]);
          gameEnd = true;
        });
      } else if ((gameState[3]) != 'empty' &&
          (gameState[3] == gameState[4]) &&
          (gameState[4] == gameState[5])) {
        setState(() {
          showWiner(gameState[3]);
          markPoints(gameState[3]);
          gameEnd = true;
        });
      } else if ((gameState[6]) != 'empty' &&
          (gameState[6] == gameState[7]) &&
          (gameState[7] == gameState[8])) {
        setState(() {
          showWiner(gameState[6]);
          markPoints(gameState[6]);
          gameEnd = true;
        });
      } else if ((gameState[0]) != 'empty' &&
          (gameState[0] == gameState[3]) &&
          (gameState[3] == gameState[6])) {
        setState(() {
          showWiner(gameState[0]);
          markPoints(gameState[0]);
          gameEnd = true;
        });
      } else if ((gameState[1]) != 'empty' &&
          (gameState[1] == gameState[4]) &&
          (gameState[4] == gameState[7])) {
        setState(() {
          showWiner(gameState[1]);
          markPoints(gameState[1]);
          gameEnd = true;
        });
      } else if ((gameState[2]) != 'empty' &&
          (gameState[2] == gameState[5]) &&
          (gameState[5] == gameState[8])) {
        setState(() {
          showWiner(gameState[2]);
          markPoints(gameState[2]);
          gameEnd = true;
        });
      } else if ((gameState[0]) != 'empty' &&
          (gameState[0] == gameState[4]) &&
          (gameState[4] == gameState[8])) {
        setState(() {
          showWiner(gameState[0]);
          markPoints(gameState[0]);
          gameEnd = true;
        });
      } else if ((gameState[2]) != 'empty' &&
          (gameState[2] == gameState[4]) &&
          (gameState[4] == gameState[6])) {
        setState(() {
          showWiner(gameState[2]);
          markPoints(gameState[2]);
          gameEnd = true;
        });
      } else if (!gameState.contains('empty')) {
        setState(() {
          showWiner('Game Draw');
          markPoints('draw');
          gameEnd = true;
        });
      }
    }
  }

  resetGame() {
    _isEnabled = true;
    setState(() {
      gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      gameEnd = false;
    });
  }

  newGame() {
    resetGame();
    setState(() {
      crossWin = 0;
      circleWin = 0;
      draw = 0;
    });
  }

  markPoints(String mark) {
    switch (mark) {
      case ('cross'):
        setState(() {
          crossWin += 1;
        });
        break;
      case ('circle'):
        setState(() {
          circleWin += 1;
        });
        break;
      case ('draw'):
        setState(() {
          draw += 1;
        });
        break;
    }
  }

  showWiner(String winer) {
//    if (!_isEnabled) return;

    String msg;
    if (winer == 'Game Draw') {
      msg = '${winer}';
    } else if (winer == 'cross') {
      msg = 'Cross wins';
    } else if (winer == 'circle') {
      msg = 'Circle wins';
    } else {
      msg = '';
    }

    _scafoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));

    _isEnabled = false;
  }
}
