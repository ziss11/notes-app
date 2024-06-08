import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failure.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class AddNote {
  final NoteRepository _noteRepository;

  const AddNote(this._noteRepository);

  Future<Either<Failure, String>> execute(String title, String description) =>
      _noteRepository.addNote(title, description);
}
