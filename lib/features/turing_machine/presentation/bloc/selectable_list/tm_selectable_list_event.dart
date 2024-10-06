part of 'tm_selectable_list_bloc.dart';

@immutable
abstract class TMListSelectableEvent {}

class TMUpdateSelectableItems extends TMListSelectableEvent {
  final List<String> items;
  TMUpdateSelectableItems({required this.items});
}

class TMUpdateSelectedIndex extends TMListSelectableEvent {
  final int selectedIndex;
  final bool isStartState;
  final bool isMultiSelectable;

  TMUpdateSelectedIndex({
    required this.selectedIndex,
    required this.isStartState,
    required this.isMultiSelectable,
  });
}

