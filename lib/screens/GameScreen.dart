import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_sdk_example/game_logic/bord_bloc.dart';
import 'package:spotify_sdk_example/components/GameScreen/Bord.dart';
import 'package:spotify_sdk_example/components/GameScreen/Players.dart';
import 'package:spotify_sdk_example/helpers/CustomTheme.dart';

//Creates and manages the GameScreen

class GameScreen extends StatefulWidget {

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with CustomTheme {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showDialog<bool>(              //When Player presses the back button
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            title: Text('Warning'),
            content: Text('Do you really want to quit?'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);  //Go back to the first screen
                  return true;
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        },
      ),
      child: Material(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF000000)
              ),
            ),

            BlocProvider<BordBloc>(
              create: (context) => BordBloc(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Players(),
                  SizedBox(
                    width: size.width,
                  ),
                  Bord(),                       //Calls Bord() to create the 3x3 grid
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
