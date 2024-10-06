part of 'animation_bloc.dart';

@immutable
sealed class AnimationEvent {}

final class StartAnimation extends AnimationEvent {
  final double targetValue;
  final Duration duration;

  StartAnimation(this.targetValue, {this.duration = const Duration(seconds: 1)});
}

final class AnimationCompleted extends AnimationEvent {}

