import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/usecases/search_notes.dart';
import 'package:viapulsa_test/presentation/cubit/search_notes_cubit.dart';

import '../../dummy_data/dummy_object.dart';
import 'search_notes_cubit_test.mocks.dart';

@GenerateMocks([SearchNotes])
void main() {
  late SearchNotesCubit cubit;
  late MockSearchNotes mockSearchNotes;

  setUp(() {
    mockSearchNotes = MockSearchNotes();
    cubit = SearchNotesCubit(mockSearchNotes);
  });

  group('Search Notes Cubit', () {
    const tQuery = 'query';

    test('initialState should be Empty', () {
      expect(cubit.state, SearchNotesInitial());
    });

    blocTest<SearchNotesCubit, SearchNotesState>(
      'should execute search notes when function called',
      build: () {
        when(mockSearchNotes.execute(tQuery))
            .thenAnswer((_) async => Right(tNotes));
        return cubit;
      },
      act: (cubit) => cubit.searchNotes(tQuery),
      verify: (cubit) => mockSearchNotes.execute(tQuery),
    );

    blocTest<SearchNotesCubit, SearchNotesState>(
      'should emits [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockSearchNotes.execute(tQuery))
            .thenAnswer((_) async => Right(tNotes));
        return cubit;
      },
      act: (cubit) => cubit.searchNotes(tQuery),
      expect: () => [
        SearchNotesLoading(),
        SearchNotesLoaded(notes: tNotes),
      ],
    );

    blocTest<SearchNotesCubit, SearchNotesState>(
      'should emits [Loading, Failed] when data is gotten successfully',
      build: () {
        when(mockSearchNotes.execute(tQuery))
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.searchNotes(tQuery),
      expect: () => [
        SearchNotesLoading(),
        const SearchNotesFailed(message: 'Server Error'),
      ],
    );
  });
}
