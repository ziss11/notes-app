import 'package:equatable/equatable.dart';
import 'package:viapulsa_test/data/models/note_model.dart';

class NoteResponse extends Equatable {
  final List<NoteModel> notes;

  const NoteResponse({required this.notes});

  factory NoteResponse.fromJson(Map<String, dynamic> json) => NoteResponse(
        notes: List<NoteModel>.from(
          (json['data'] as List).map((x) => NoteModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(notes.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [notes];
}
