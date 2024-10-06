import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_selection_event.dart';
part 'single_selection_state.dart';

class SingleSelectionBloc<T> extends Bloc<SingleSelectionEvent<T>, SingleSelectionState<T>> {
  SingleSelectionBloc() : super(SingleSelectionInitial<T>()) {
    on<SingleSelectItemEvent<T>>(_onSelectItem);

    on<ResetSelectionEvent<T>>((event, emit) {
      emit(SingleSelectionInitial<T>());
    });
  }

  void _onSelectItem(SingleSelectItemEvent<T> event, Emitter<SingleSelectionState<T>> emit) {
    emit(SingleSelectionUpdated<T>(selectedItem: event.selectedItem));
  }
}
