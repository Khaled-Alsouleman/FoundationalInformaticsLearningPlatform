part of 'tm_selectable_list_bloc.dart';

@immutable
abstract class TMListSelectableState {}

class TMListSelectableInitial extends TMListSelectableState {}

class TMListSelectableUpdated extends TMListSelectableState {
  final List<String> items;
  final List<int> startStateIndices;
  final List<int> endStateIndices;

  TMListSelectableUpdated({
    required this.items,
    required this.startStateIndices,
    required this.endStateIndices,
  });
}


