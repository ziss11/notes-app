import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/domain/usecases/add_note.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late AddNote usecase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    usecase = AddNote(mockNoteRepository);
  });

  const tNoteTitle = 'title';
  const tNoteDescription = 'description';

  test('should create new note when execute function is called', () async {
    // arrange
    when(mockNoteRepository.addNote(tNoteTitle, tNoteDescription))
        .thenAnswer((_) async => const Right(Constants.successAddNoteMsg));
    // act
    final result = await usecase.execute(tNoteTitle, tNoteDescription);
    // assert
    verify(mockNoteRepository.addNote(tNoteTitle, tNoteDescription));
    expect(result, const Right(Constants.successAddNoteMsg));
  });
}
