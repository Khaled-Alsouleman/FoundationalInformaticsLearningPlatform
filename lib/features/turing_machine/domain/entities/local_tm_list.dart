import 'package:foundational_learning_platform/core/utils/index.dart';

class LocalTMList {
  final String id;
  final String name;
  final String description;
  final TuringMachine tm;

  LocalTMList({
    required this.id,
    required this.name,
    required this.description,
    required this.tm,
  });


  factory LocalTMList.fromMap(Map<String, dynamic> map) {
    return LocalTMList(
      id: map['id'] ?? const Uuid().v4(),
      name: map['name'],
      description: map['description'],
      tm: TuringMachine.fromMap(map),
    );
  }


  // Method to convert instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tm': tm.toMap(),
    };
  }

  factory LocalTMList.fromJson(String source) {
    final decodedJson = json.decode(source) as Map<String, dynamic>;
    return LocalTMList.fromMap(decodedJson);
  }
}
