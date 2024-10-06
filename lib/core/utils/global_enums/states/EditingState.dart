enum EditingState {
  editing,
  complete,
  error,
}

extension EditingStateExtension on EditingState {
  bool get isComplete => this == EditingState.complete;
  bool get isEditing => this == EditingState.editing;
  bool get isError => this == EditingState.error;
}
