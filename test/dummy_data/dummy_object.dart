import 'package:viapulsa_test/data/models/note_model.dart';
import 'package:viapulsa_test/domain/entities/note.dart';

final tNote = Note(
  id: 'id',
  title: 'title',
  description: 'description',
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

final tNotes = [tNote];

final tNoteModel = NoteModel(
  id: 'id',
  title: 'title',
  description: 'description',
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

final tNoteModels = [tNoteModel];
