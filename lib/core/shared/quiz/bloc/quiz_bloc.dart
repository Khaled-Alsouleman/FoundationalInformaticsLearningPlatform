import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<TrueAnswerEvent>((event, emit) {
      emit(TrueAnswer());
     print("TrueAnswerEvent");
    });
    on<WrongAnswerEvent>((event, emit) {
      emit(WrongAnswer());
      print("WrongAnswerEvent");
    });
  }
}
