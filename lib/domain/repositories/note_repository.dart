import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, List<Note>>> searchNotes(String query);
  Future<Either<Failure, Note>> getNoteById(String id);
  Future<Either<Failure, String>> addNote(String title, String description);
  Future<Either<Failure, String>> editNote(
    String id,
    String title,
    String description,
  );
  Future<Either<Failure, String>> deleteNote(String id);
}
