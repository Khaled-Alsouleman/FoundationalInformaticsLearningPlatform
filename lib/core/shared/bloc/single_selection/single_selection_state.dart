part of 'single_selection_bloc.dart';

@immutable
abstract class SingleSelectionState<T> {}

class SingleSelectionInitial<T> extends SingleSelectionState<T> {}

class SingleSelectionUpdated<T> extends SingleSelectionState<T> {
  final T selectedItem;

  SingleSelectionUpdated({required this.selectedItem});
}
