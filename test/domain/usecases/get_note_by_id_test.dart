import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/domain/usecases/get_note_by_id.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNoteById usecase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    usecase = GetNoteById(mockNoteRepository);
  });

  const tId = 'id';

  test(
      'should return note detail from the repository when execute function is called',
      () async {
    // arrange
    when(mockNoteRepository.getNoteById(tId))
        .thenAnswer((_) async => Right(tNote));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tNote));
  });
}
