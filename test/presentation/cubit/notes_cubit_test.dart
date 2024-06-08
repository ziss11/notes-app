import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/usecases/get_notes.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';

import '../../dummy_data/dummy_object.dart';
import 'notes_cubit_test.mocks.dart';

@GenerateMocks([GetNotes])
void main() {
  late NotesCubit cubit;
  late MockGetNotes mockGetNotes;

  setUp(() {
    mockGetNotes = MockGetNotes();
    cubit = NotesCubit(mockGetNotes);
  });

  group('All Notes Cubit', () {
    test('initialState should be Empty', () {
      expect(cubit.state, AllNotesInitial());
    });

    blocTest<NotesCubit, NotesState>(
      'should execute get notes when function called',
      build: () {
        when(mockGetNotes.execute()).thenAnswer((_) async => Right(tNotes));
        return cubit;
      },
      act: (cubit) => cubit.fetchNotes(),
      verify: (bloc) => mockGetNotes.execute(),
    );

    blocTest<NotesCubit, NotesState>(
      'should emits [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNotes.execute()).thenAnswer((_) async => Right(tNotes));
        return cubit;
      },
      act: (cubit) => cubit.fetchNotes(),
      expect: () => [
        AllNotesLoading(),
        AllNotesLoaded(notes: tNotes),
      ],
    );

    blocTest<NotesCubit, NotesState>(
      'should emits [Loading, Failed] when data is gotten successfully',
      build: () {
        when(mockGetNotes.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.fetchNotes(),
      expect: () => [
        AllNotesLoading(),
        const AllNotesFailed(message: 'Server Error'),
      ],
    );
  });
}
