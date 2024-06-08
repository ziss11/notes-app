import 'package:viapulsa_test/data/models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<void> cacheNotes(List<NoteModel> notes);
  Future<void> clearCacheNotes();
  Future<List<NoteModel>> getCachedNotes();
}
