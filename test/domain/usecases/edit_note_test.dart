import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/domain/usecases/edit_note.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late EditNote usecase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    usecase = EditNote(mockNoteRepository);
  });

  const tId = 'id';
  const tNoteTitle = 'title';
  const tNoteDescription = 'description';

  test('should edit existing note when execute function is called', () async {
    // arrange
    when(mockNoteRepository.editNote(tId, tNoteTitle, tNoteDescription))
        .thenAnswer((_) async => const Right(Constants.successEditNoteMsg));
    // act
    final result = await usecase.execute(tId, tNoteTitle, tNoteDescription);
    // assert
    verify(mockNoteRepository.editNote(tId, tNoteTitle, tNoteDescription));
    expect(result, const Right(Constants.successEditNoteMsg));
  });
}
