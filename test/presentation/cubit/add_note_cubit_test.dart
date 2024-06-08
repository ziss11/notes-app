import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/usecases/add_note.dart';
import 'package:viapulsa_test/presentation/cubit/add_note_cubit.dart';

import 'add_notes_cubit_test.mocks.dart';

@GenerateMocks([AddNote])
void main() {
  late AddNoteCubit cubit;
  late MockAddNote mockAddNote;

  setUp(() {
    mockAddNote = MockAddNote();
    cubit = AddNoteCubit(mockAddNote);
  });

  group('Add Notes Cubit', () {
    const tNoteTitle = 'title';
    const tNoteDescription = 'description';

    test('initialState shold be Empty', () {
      expect(cubit.state, AddNoteInitial());
    });

    blocTest<AddNoteCubit, AddNoteState>(
      'should execute add note when function called',
      build: () {
        when(mockAddNote.execute(tNoteTitle, tNoteDescription))
            .thenAnswer((_) async => const Right(Constants.successAddNoteMsg));
        return cubit;
      },
      act: (cubit) => cubit.addNote(tNoteTitle, tNoteDescription),
      verify: (cubit) => mockAddNote.execute(tNoteTitle, tNoteDescription),
    );

    blocTest<AddNoteCubit, AddNoteState>(
      'should emits [Loading, Success] when add note successfully',
      build: () {
        when(mockAddNote.execute(tNoteTitle, tNoteDescription))
            .thenAnswer((_) async => const Right(Constants.successAddNoteMsg));
        return cubit;
      },
      act: (cubit) => cubit.addNote(tNoteTitle, tNoteDescription),
      expect: () => [
        AddNoteLoading(),
        const AddNoteSuccess(message: Constants.successAddNoteMsg),
      ],
    );

    blocTest<AddNoteCubit, AddNoteState>(
      'should emits [Loading, Failed] when add note successfully',
      build: () {
        when(mockAddNote.execute(tNoteTitle, tNoteDescription))
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.addNote(tNoteTitle, tNoteDescription),
      expect: () => [
        AddNoteLoading(),
        const AddNoteFailed(message: 'Server Error'),
      ],
    );
  });
}
