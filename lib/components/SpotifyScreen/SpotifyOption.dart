import 'package:flutter/material.dart';
import 'package:spotify_sdk_example/helpers/CustomTheme.dart';
import 'package:google_fonts/google_fonts.dart';

//Creates the buttons on the Spotify Screen

class SpotifyOption extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  SpotifyOption({@required this.title, @required this.onTap});
  @override
  _SpotifyOptionState createState() => _SpotifyOptionState();
}

class _SpotifyOptionState extends State<SpotifyOption> with CustomTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(                 //Button Design
        alignment: Alignment.center,
        width: 240,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
            color: Color(0xff1db954)
        ),
        child: Text(
          widget.title,
            style: GoogleFonts.openSans(color: Colors.white, fontSize:25, fontWeight: FontWeight.w700)
        ),
      ),
    );
  }
}
