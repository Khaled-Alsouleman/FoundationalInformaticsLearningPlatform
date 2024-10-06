part of 'animation_bloc.dart';

@immutable
sealed class AnimationState {}

final class AnimationInitial extends AnimationState {}

final class AnimationRunning extends AnimationState {
  final double value;

  AnimationRunning(this.value);
}
