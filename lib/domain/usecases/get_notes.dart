import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failure.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class GetNotes {
  final NoteRepository _noteRepository;

  const GetNotes(this._noteRepository);

  Future<Either<Failure, List<Note>>> execute() => _noteRepository.getNotes();
}
