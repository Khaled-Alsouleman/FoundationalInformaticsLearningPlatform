part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}


final class TrueAnswerEvent extends QuizEvent {}
final class WrongAnswerEvent extends QuizEvent {}