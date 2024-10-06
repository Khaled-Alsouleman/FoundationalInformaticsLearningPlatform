import 'package:equatable/equatable.dart';
import 'package:foundational_learning_platform/core/utils/index.dart';

abstract class Failure  extends Equatable{
  final String message;

  const Failure({required this.message});

  @override
  String toString() => message;
}
