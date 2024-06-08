import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class GetNoteById {
  final NoteRepository _noteRepository;

  const GetNoteById(this._noteRepository);

  Future<Either<Failure, Note>> execute(String id) =>
      _noteRepository.getNoteById(id);
}
