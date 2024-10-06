part of 'content_bloc.dart';

@immutable
sealed class ContentEvent {}

class BackToHome extends ContentEvent{}

class UpdateContent extends ContentEvent{
  final BuildContext context;
  final Widget newContent;
  UpdateContent({required this.context,required this.newContent});
}
