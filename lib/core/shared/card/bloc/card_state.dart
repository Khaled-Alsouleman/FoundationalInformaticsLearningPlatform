part of 'card_bloc.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

class CardHoverInProgress extends CardState {}

class CardHoverComplete extends CardState {}

class CardTappedState extends CardState {
  final String screen;

  CardTappedState(this.screen);
}
