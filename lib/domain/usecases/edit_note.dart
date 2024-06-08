import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class EditNote {
  final NoteRepository _noteRepository;

  const EditNote(this._noteRepository);

  Future<Either<Failure, String>> execute(
    String id,
    String title,
    String description,
  ) =>
      _noteRepository.editNote(id, title, description);
}
