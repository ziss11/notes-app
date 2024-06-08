import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/domain/usecases/delete_note.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteNote usecase;
  late MockNoteRepository mockRepository;

  setUp(() {
    mockRepository = MockNoteRepository();
    usecase = DeleteNote(mockRepository);
  });

  const tId = 'id';

  test('should delete existing note when execute function is called', () async {
    // arrange
    when(mockRepository.deleteNote(tId))
        .thenAnswer((_) async => const Right(Constants.successDeleteNoteMsg));
    // act
    final result = await usecase.execute(tId);
    // assert
    verify(mockRepository.deleteNote(tId));
    expect(result, const Right(Constants.successDeleteNoteMsg));
  });
}
