import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_sdk_example/game_logic/bord_bloc.dart';
import 'package:spotify_sdk_example/helpers/CustomTheme.dart';
import 'package:google_fonts/google_fonts.dart';

// Makes the Player Avatar Boxes in the GameScreen


class Players extends StatefulWidget {
  Players();
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> with CustomTheme {
  BordBloc bordBloc;
  String playerOneAvatar;
  String playerOneName;
  String playerTwoAvatar;
  String playerTwoName;

  @override
  void initState() {
    playerOneAvatar = "assets/You.jpg";      //Avatar Images
    playerOneName = "You";
    playerTwoAvatar = "assets/Bot.jpg";     //Avatar Images
    playerTwoName = "Bot";
    super.initState();
  }

  @override
  void dispose() {
    bordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bordBloc = BlocProvider.of<BordBloc>(context);

    return BlocBuilder<BordBloc, BordState>(
      bloc: bordBloc,
      builder: (context, state) {
        Color color1 = Colors.yellow;
        Color color2 = Colors.red;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildPlayerBox(color1, true),
            buildPlayerBox(color2, false),
          ],
        );
      },
    );
  }

  Widget buildPlayerBox(Color color, bool isPlayerOne) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 4),
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff494848),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Image.asset(
                (isPlayerOne) ? playerOneAvatar : playerTwoAvatar,

              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (isPlayerOne) ? playerOneName : playerTwoName,
            style: GoogleFonts.openSans(color: Colors.white, fontSize:25, fontWeight: FontWeight.w700)
          ),
          (isPlayerOne)
              ? Image.asset(
            "assets/symbol_y.jpg",    //Player Symbols
          )
              : Image.asset(
            "assets/symbol_x.jpg",    //Player Symbols
          ),
        ],
      ),
    );
  }
}
