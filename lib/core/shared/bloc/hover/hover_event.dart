part of 'hover_bloc.dart';

@immutable
abstract class HoverEvent {}

class OnHoverEnter extends HoverEvent {}

class OnHoverExit extends HoverEvent {}
