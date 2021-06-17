part of 'bord_bloc.dart';

@immutable
abstract class BordEvent {}
// For the User Tap class
class Tap extends BordEvent {
  final int index;
  Tap({@required this.index});
}
