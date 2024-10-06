import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'animation_event.dart';
part 'animation_state.dart';

class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  Timer? _animationTimer;
  AnimationBloc() : super(AnimationInitial()) {
    on<StartAnimation>((event, emit) async {
      const int steps = 20; // Anzahl der Schritte in der Animation
      final double stepValue = (event.targetValue - 1.0) / steps;
      final int stepDuration = event.duration.inMilliseconds ~/ steps;

      for (int i = 0; i <= steps; i++) {
        await Future.delayed(Duration(milliseconds: stepDuration));
        emit(AnimationRunning(1.0 + stepValue * i));
      }

      // Animation abgeschlossen, löse das AnimationCompleted-Event aus
      add(AnimationCompleted());
    });

    on<AnimationCompleted>((event, emit) {
      // Setze den Zustand zurück oder führe andere Bereinigungen durch
      emit(AnimationInitial());
      _animationTimer?.cancel();
      _animationTimer = null;
    });
  }

  @override
  Future<void> close() {
    // Stellt sicher, dass alle Ressourcen freigegeben werden, wenn der Bloc geschlossen wird
    _animationTimer?.cancel();
    return super.close();
  }
}


