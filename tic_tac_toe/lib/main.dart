import 'package:flutter/material.dart';

import 'tic_tac_toe_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var game = TicTacToeGame();

  String get gameStateString {
    switch (game.state) {
      case TicTacToeState.xTurn:
        return "X's Turn";
      case TicTacToeState.oTurn:
        return "O's Turn";
      case TicTacToeState.xWon:
        return "X Won!";
      case TicTacToeState.oWon:
        return "O Won!";
      case TicTacToeState.tie:
        return "Tie Game";
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];
    for (var k = 0; k < 9; k++) {
      buttons.add(
        InkWell(
          onTap: () {
            // print("You pressed button number $k");
            setState(() {
              game.pressedSquare(k);
            });
          },
          child: Image.asset(
              (game.board[k] == TicTacToeMark.x)
                  ? "assets/images/x.png"
                  : ((game.board[k] == TicTacToeMark.o)
                      ? "assets/images/o.png"
                      : "assets/images/blank.png"),
              // style: TextStyle(fontSize: 90.0),
              fit: BoxFit.fill),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red[800],
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              Text(
                gameStateString,
                style: Theme.of(context).textTheme.headline2,
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/board.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Expanded(
                      child: GridView.count(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        crossAxisCount: 3,
                        children: buttons,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        game = TicTacToeGame();
                      });
                    },
                    child: const Text(
                      "New Game",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
