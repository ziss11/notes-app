import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/domain/usecases/get_notes.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNotes usecase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    usecase = GetNotes(mockNoteRepository);
  });

  test(
      'should get list of note from the repository when execute function is called',
      () async {
    // arrange
    when(mockNoteRepository.getNotes()).thenAnswer((_) async => Right(tNotes));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tNotes));
  });
}
