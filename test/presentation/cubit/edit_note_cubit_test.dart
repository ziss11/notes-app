import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/usecases/edit_note.dart';
import 'package:viapulsa_test/presentation/cubit/edit_note_cubit.dart';

import 'edit_note_cubit_test.mocks.dart';

@GenerateMocks([EditNote])
void main() {
  late EditNoteCubit cubit;
  late MockEditNote mockEditNote;

  setUp(() {
    mockEditNote = MockEditNote();
    cubit = EditNoteCubit(mockEditNote);
  });

  group('Edit Note Cubit', () {
    const tId = 'id';
    const tNoteTitle = 'title';
    const tNoteDescription = 'description';

    test('initialState should be empty', () {
      expect(cubit.state, EditNoteInitial());
    });

    blocTest<EditNoteCubit, EditNoteState>(
      'should execute edit note when function called',
      build: () {
        when(mockEditNote.execute(tId, tNoteTitle, tNoteDescription))
            .thenAnswer((_) async => const Right(Constants.successEditNoteMsg));
        return cubit;
      },
      act: (cubit) => cubit.editNote(tId, tNoteTitle, tNoteDescription),
      verify: (cubit) =>
          mockEditNote.execute(tId, tNoteTitle, tNoteDescription),
    );

    blocTest<EditNoteCubit, EditNoteState>(
      'should emits [Loading, Success] when edit note successfully',
      build: () {
        when(mockEditNote.execute(tId, tNoteTitle, tNoteDescription))
            .thenAnswer((_) async => const Right(Constants.successEditNoteMsg));
        return cubit;
      },
      act: (cubit) => cubit.editNote(tId, tNoteTitle, tNoteDescription),
      expect: () => [
        EditNoteLoading(),
        const EditNoteSuccess(message: Constants.successEditNoteMsg),
      ],
    );

    blocTest<EditNoteCubit, EditNoteState>(
      'should emits [Loading, Failed] when edit note successfully',
      build: () {
        when(mockEditNote.execute(tId, tNoteTitle, tNoteDescription))
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.editNote(tId, tNoteTitle, tNoteDescription),
      expect: () => [
        EditNoteLoading(),
        const EditNoteFailed(message: 'Server Error'),
      ],
    );
  });
}
