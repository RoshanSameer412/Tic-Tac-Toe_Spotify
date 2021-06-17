import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk_example/helpers/CustomTheme.dart';
import 'package:google_fonts/google_fonts.dart';

//Result Screen to show the result after the game has ended

class Results extends StatefulWidget {
  final int result;
  Results({@required this.result});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> with CustomTheme {
  String winningImage;
  String winningText;

  @override
  void initState() {
    if (widget.result == 1) {
      winningImage = "assets/win.gif";
      winningText = "YOU WON!";
    } else if (widget.result == -1) {
      winningImage = "assets/lose.gif";
      winningText = "YOU LOST!";
    } else {
      winningImage = "assets/draw.gif";
      winningText = "IT'S A DRAW!";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {            //Creates the ResultScreen to show the result with a GIF
    final size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: size.width),
              Image.asset(
                winningImage,
                scale: 1,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                winningText,
                  style: GoogleFonts.openSans(color: Colors.white, fontSize:30, fontWeight: FontWeight.w700)
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(                              //Goes back to the HomeScreen
                onTap: () {
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  );
                },
                child: Icon(
                    Icons.replay,
                    color: Colors.white,
                    size: 50,
                  ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
