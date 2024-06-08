import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class SearchNotes {
  final NoteRepository _noteRepository;

  const SearchNotes(this._noteRepository);

  Future<Either<Failure, List<Note>>> execute(String query) =>
      _noteRepository.searchNotes(query);
}
