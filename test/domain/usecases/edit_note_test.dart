import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/domain/usecases/edit_note.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late EditNote usecase;
  late MockNoteRepository mockRepository;

  setUp(() {
    mockRepository = MockNoteRepository();
    usecase = EditNote(mockRepository);
  });

  const tId = 'id';
  const tNoteTitle = 'title';
  const tNoteDescription = 'description';

  test('should edit existing note when execute function is called', () async {
    // arrange
    when(mockRepository.editNote(tId, tNoteTitle, tNoteDescription))
        .thenAnswer((_) async => const Right(Constants.successEditNoteMsg));
    // act
    final result = await usecase.execute(tId, tNoteTitle, tNoteDescription);
    // assert
    verify(mockRepository.editNote(tId, tNoteTitle, tNoteDescription));
    expect(result, const Right(Constants.successEditNoteMsg));
  });
}
