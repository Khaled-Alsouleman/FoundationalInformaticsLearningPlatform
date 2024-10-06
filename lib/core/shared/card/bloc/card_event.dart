part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class CardHoverStarted extends CardEvent {}

class CardHoverEnded extends CardEvent {}

class CardTapped extends CardEvent {
  final String screen;

  CardTapped(this.screen);
}
