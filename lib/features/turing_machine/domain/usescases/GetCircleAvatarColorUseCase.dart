import 'package:foundational_learning_platform/core/utils/index.dart';

class GetCircleAvatarColorUseCase {
  Color call(EditingState status) {
    switch (status) {
      case EditingState.complete:
        return Colors.green;
      case EditingState.editing:
        return Colors.yellow;
      case EditingState.error:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
