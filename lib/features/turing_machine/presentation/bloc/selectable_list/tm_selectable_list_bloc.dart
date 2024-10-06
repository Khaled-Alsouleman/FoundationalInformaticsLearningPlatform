import 'package:foundational_learning_platform/core/utils/index.dart';
part 'tm_selectable_list_event.dart';
part 'tm_selectable_list_state.dart';

class TMListSelectableBloc extends Bloc<TMListSelectableEvent, TMListSelectableState> {
  List<String> items = [];
  List<int> startStateIndices = [];
  List<int> endStateIndices = [];

  TMListSelectableBloc() : super(TMListSelectableInitial()) {
    on<TMUpdateSelectableItems>(_handleUpdateSelectableItems);
    on<TMUpdateSelectedIndex>(_handleUpdateSelectedIndex);
  }

  void _handleUpdateSelectableItems(TMUpdateSelectableItems event, Emitter<TMListSelectableState> emit) {
    items = event.items;
    startStateIndices = [];
    endStateIndices = [];
    emit(TMListSelectableUpdated(
      items: items,
      startStateIndices: startStateIndices,
      endStateIndices: endStateIndices,
    ));
  }

  void _handleUpdateSelectedIndex(TMUpdateSelectedIndex event, Emitter<TMListSelectableState> emit) {
    if (event.isStartState) {
      if (event.isMultiSelectable) {
        _updateMultiSelection(startStateIndices, event.selectedIndex);
      } else {
        _updateSingleSelection(startStateIndices, event.selectedIndex);
      }
    } else {
      if (event.isMultiSelectable) {
        _updateMultiSelection(endStateIndices, event.selectedIndex);
      } else {
        _updateSingleSelection(endStateIndices, event.selectedIndex);
      }
    }

    emit(TMListSelectableUpdated(
      items: items,
      startStateIndices: startStateIndices,
      endStateIndices: endStateIndices,
    ));
  }

  void _updateSingleSelection(List<int> indices, int selectedIndex) {
    indices.clear();
    indices.add(selectedIndex);
  }

  void _updateMultiSelection(List<int> indices, int selectedIndex) {
    if (indices.contains(selectedIndex)) {
      indices.remove(selectedIndex);
    } else {
      indices.add(selectedIndex);
    }
  }
}

