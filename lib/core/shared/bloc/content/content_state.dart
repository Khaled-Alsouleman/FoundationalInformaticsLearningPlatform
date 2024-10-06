part of 'content_bloc.dart';

@immutable
sealed class ContentState {}

final class ContentInitial extends ContentState {}

final class UpdatedContent extends ContentState {
  final Widget currentContent;
  UpdatedContent({ required this.currentContent});
}
