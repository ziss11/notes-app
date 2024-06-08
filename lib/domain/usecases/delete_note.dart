import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failure.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class DeleteNote {
  final NoteRepository _noteRepository;

  const DeleteNote(this._noteRepository);

  Future<Either<Failure, String>> execute(String id) =>
      _noteRepository.deleteNote(id);
}
