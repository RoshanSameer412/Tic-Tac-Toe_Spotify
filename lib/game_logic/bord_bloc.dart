import 'dart:async';
import 'dart:math';

import '../game_logic/minimax_algorithm.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bord_event.dart';
part 'bord_state.dart';

// Decides the moves of the Game Logic depending on the Player's moves
// Makes the game easy or hard based on the random function

class BordBloc extends Bloc<BordEvent, BordState> {
  List<int> _bordState = [55, 55, 55, 55, 55, 55, 55, 55, 55];  // initial scores for each block
  bool playerOneTurn = true;
  int currentMove = 0;
  int winner;


  List<int> get getBordState => _bordState;

  @override
  BordInitial get initialState => BordInitial();

  @override
  Stream<BordState> mapEventToState(
    BordEvent event,
  ) async* {
    if (event is Tap) {
      currentMove++;                          //counter for Player's each move
      updateBord(event.index);
      winner = checkWinner(_bordState);
      if (winner != null) {                   //Checks if the game is over
        yield GameResult(_bordState, result: winner);
      } else
        yield UpdateBord(bordState: _bordState);
    }
  }

  void updateBord(int index) {
    if (playerOneTurn && _bordState[index] != 1 && _bordState[index] != 0) {
      _bordState[index] = 0;
      playerOneTurn = false;

      if (checkWinner(_bordState) != 1) {
        Botselect();                                // Botselect() is used to decide whether the game is easy or hard
        playerOneTurn = true;
      }
    } else if (_bordState[index] != 0 && _bordState[index] != 1) {
      _bordState[index] = 1;
      playerOneTurn = true;
    }
  }

  void hardBot() {                              // The most efficient use of the Minimax Algorithm, the game is unbeatable
    int bestScore = 55;
    int move;

    for (int i = 0; i < 9; i++) {
      if (_bordState[i] != 0 && _bordState[i] != 1) {
        _bordState[i] = 1;
        int score = minimax(_bordState, 0, false);
        _bordState[i] = 55;
        if (score < bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    if (move != null) _bordState[move] = 1;
  }

  void easyBot() {                            //Uses a random number to decrease the number of moves
                                              // decided by the game logic, thus making it easier for the
                                              //player to win
    int move = Random().nextInt(2);
    bool isPlayed = false;
    while (!isPlayed && currentMove < 5) {
      if (_bordState[move] != 0 && _bordState[move] != 1) {
        _bordState[move] = 1;
        isPlayed = true;
      } else {
        move = Random().nextInt(9);
      }
    }
  }

  void Botselect() {                    //Botselect() is used to decide whether the game is easy or hard
    bool luck = false;
    luck = Random().nextBool();
    if (luck && currentMove < 2) {
      easyBot();
    } else {
      hardBot();
    }
  }
}
