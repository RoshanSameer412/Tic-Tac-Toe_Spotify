import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk_example/helpers/CustomTheme.dart';
import 'package:spotify_sdk_example/components/homeScreen/HomeOption.dart';
import 'package:spotify_sdk_example/screens/GameScreen.dart';
import 'package:spotify_sdk_example/screens/SpotifyScreen.dart';

//Creates and manages the HomeScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CustomTheme {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:

      Stack(
        children: [                           //Makes the UI of the HomeScreen
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: sbgColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icon/icon.png',height: 250,width: 250,fit: BoxFit.fitWidth),
              SizedBox(
                width: size.width,
              ),
              SizedBox(
                height: 50,
              ),
              GameOption(                                 //Calls GameOption to make the buttons
                title: "Start Game",
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => GameScreen(),
                  ),
                ),
              ),
                SizedBox(
                height: 40,
                ),
                GameOption(
                title: "Spotify",
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) =>
                          BotScreen(),
                    ),
                  );
                },
              ),

              SizedBox(
                height: 40,
              ),

              TextButton(
                onPressed: () => showDialog<String>(            // Instructions for the Players
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Instructions:'),
                    content: const Text('Tic-Tac-Toe is a classic yet simple game.\n\nThis game has a 3x3 grid and you have to fill your symbol ( O ) in 3 (horizontally/vertically/diagonally) consecutive blocks.\n\nYou are up against a bot trying to defeat you.\n\n All the best!'),
                    backgroundColor: Colors.grey,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Got it!', style: TextStyle(color: Colors.black)),

                      ),
                    ],
                  ),
                ),
                child: const Text('How to Play?'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

