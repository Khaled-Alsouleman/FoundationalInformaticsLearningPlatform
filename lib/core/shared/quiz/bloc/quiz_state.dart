part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class TrueAnswer extends QuizState {}

final class WrongAnswer extends QuizState {}
