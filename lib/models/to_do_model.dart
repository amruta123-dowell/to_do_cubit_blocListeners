import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter { all, active, completed }

///UUID
Uuid uuid = const Uuid();

class ToDoModel extends Equatable {
  final String id;
  final String description;
  final bool isCompleted;

  ToDoModel({String? id, required this.description, this.isCompleted = false})
      : id = id ?? uuid.v4();

  @override
  List<Object?> get props => [id, description, isCompleted];

  @override
  String toString() =>
      "id:$id     description:$description  isCompleted: $isCompleted";
}
