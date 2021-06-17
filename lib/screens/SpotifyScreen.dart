import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk_example/helpers/CustomTheme.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk_example/components/SpotifyScreen/SpotifyOption.dart';

//For the User to connect to the Spotify App
//Authorize, Connect, Play/Pause Songs


class BotScreen extends StatefulWidget {
  @override
  _BotScreenState createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> with CustomTheme {
  bool _loading = false;
  bool _connected = false;
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color c = Color(0xFF000000);

    return MaterialApp(

      theme : ThemeData(
        scaffoldBackgroundColor: Color(0xFF000000)
      ),

      home: StreamBuilder<ConnectionStatus>(
        stream: SpotifySdk.subscribeConnectionStatus(),
        builder: (context, snapshot) {
          _connected = false;
          if (snapshot.data != null) {
            _connected = snapshot.data.connected;
          }
          return Scaffold(

              body: _sampleFlowWidget(context),

          );
        },
      ),
    );
  }

  Widget _sampleFlowWidget(BuildContext context2) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(8),
          children: [                                       //Buttons for the screen

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 150,
                ),

                SizedBox(
                  width: size.width,
                ),

                SizedBox(
                  height: 50,
                ),

                SpotifyOption(
                  title: "Authorize",
                  onTap: getAuthenticationToken         //Authorize the App by getting a token
                ),

                SizedBox(
                  height: 40,
                ),

                SpotifyOption(
                  title: "Connect to Spotify",
                  onTap: connectToSpotifyRemote         //Connect the App to the Spotify App
                ),

                SizedBox(
                  height: 50,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: resume,

                  child: Icon(
                  Icons.play_circle_sharp,            //Play the song
                  color: Colors.white,
                  size: 70,
                  ),
                ),

                InkWell(
                  onTap: pause,                            //Pause the Song
                  child: Icon(
                    Icons.pause_circle_sharp,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  width: size.width,
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
            TextButton(                                   //Instructions for the User
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Instructions:'),
                  content: const Text('Listen to your favourite songs while playing the game.\n\nAuthorize : For first time users, you need to authorize this app to connect to your Spotify app.\n\nConnect to Spotify: Link this app with your Spotify App.\n\n NOTE : You need to have the latest version of Spotify app installed on your device.'),
                  backgroundColor: Colors.grey,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Got it!', style: TextStyle(color: Colors.black)),

                    ),
                  ],
                ),
              ),
              child:  Icon(
                Icons.info_sharp,
                color: Colors.white,
                size: 40,
              ),
            ),

            SizedBox(
                  height: 20,
                ),
            InkWell(
              onTap: () {
                Navigator.of(context).popUntil(
                      (route) => route.isFirst,
                );
              },
              child: Icon(
                  Icons.keyboard_return_sharp,
                  color: Colors.white,
                  size: 35,
                ),
              ),
          ],
        ),
        _loading
            ? Container(
            color: Colors.black12,
            child: const Center(child: CircularProgressIndicator()))
            : const SizedBox(),
      ],
    );
  }

  Future<void> connectToSpotifyRemote() async {       //Function implementing ConnectSpotify
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: env['CLIENT_ID'].toString(),
          redirectUrl: env['REDIRECT_URL'].toString());
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<String> getAuthenticationToken() async {         //Function to get token
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: env['CLIENT_ID'].toString(),
          redirectUrl: env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      return authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }



  Future<void> pause() async {            //Pause the song
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> resume() async {         //Play the song
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void setStatus(String code, {String message = ''}) {
    var text = message.isEmpty ? '' : ' : $message';
    _logger.d('$code$text');
  }
}
