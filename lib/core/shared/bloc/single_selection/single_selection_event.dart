part of 'single_selection_bloc.dart';

@immutable
abstract class SingleSelectionEvent<T> {}

class SingleSelectItemEvent<T> extends SingleSelectionEvent<T> {
  final T selectedItem;

  SingleSelectItemEvent({required this.selectedItem});

}

class ResetSelectionEvent<T> extends SingleSelectionEvent<T> {}
