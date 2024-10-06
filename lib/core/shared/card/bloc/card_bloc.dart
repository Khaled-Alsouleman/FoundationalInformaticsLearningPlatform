import 'package:bloc/bloc.dart';
import 'package:foundational_learning_platform/core/shared/card/bloc/card_bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<CardHoverStarted>((event, emit) {
      emit(CardHoverInProgress());
    });
    on<CardHoverEnded>((event, emit) {
      emit(CardHoverComplete());
    });
    on<CardTapped>((event, emit) {
      emit(CardTappedState(event.screen));
    });
  }
}
