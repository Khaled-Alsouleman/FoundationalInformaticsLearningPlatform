enum MovementDirection {
  rechts,
  links,
  bleiben,
  right,
  left,
  stay;

  // Methode, um den enum Namen als String zu bekommen
  String get displayName {
    return toString().split('.').last;
  }

  static MovementDirection fromString(String value) {
    switch (value.toLowerCase()) {
      case 'right':
      case 'RIGHT':
      case 'rechts':
        return MovementDirection.rechts;
      case 'left':
      case 'LEFT':
      case 'links':
        return MovementDirection.links;
      case 'stay':
      case 'STAY':
      case 'bleiben':
        return MovementDirection.bleiben;
      default:
        throw ArgumentError("Invalid movement direction: $value");
    }
  }
}
