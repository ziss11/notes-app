import 'package:viapulsa_test/data/models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes();
  Future<NoteModel> getNoteById(String id);
  Future<String> addNote(String title, String description);
  Future<String> editNote(String id, String title, String description);
  Future<String> deleteNote(String id);
}
