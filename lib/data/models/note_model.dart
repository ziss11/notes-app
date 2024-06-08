import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:viapulsa_test/domain/entities/note.dart';

part 'generated/note_model.g.dart';

@JsonSerializable()
class NoteModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  Note toEntity() => Note(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        updatedAt,
      ];
}
