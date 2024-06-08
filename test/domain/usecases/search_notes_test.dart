import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/domain/usecases/search_notes.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchNotes usecase;
  late MockNoteRepository mockRepository;

  setUp(() {
    mockRepository = MockNoteRepository();
    usecase = SearchNotes(mockRepository);
  });

  const tQuery = 'query';

  test(
      'should get list of note from the repository when execute function is called',
      () async {
    // arrange
    when(mockRepository.searchNotes(tQuery))
        .thenAnswer((_) async => Right(tNotes));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tNotes));
  });
}
