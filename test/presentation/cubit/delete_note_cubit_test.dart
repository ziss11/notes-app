import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/usecases/delete_note.dart';
import 'package:viapulsa_test/presentation/cubit/delete_note_cubit.dart';

import 'delete_note_cubit_test.mocks.dart';

@GenerateMocks([DeleteNote])
void main() {
  late DeleteNoteCubit cubit;
  late MockDeleteNote mockDeleteNote;

  setUp(() {
    mockDeleteNote = MockDeleteNote();
    cubit = DeleteNoteCubit(mockDeleteNote);
  });

  group('Delete Note Cubit', () {
    const tId = 'id';

    test('initialState should be Empty', () {
      expect(cubit.state, DeleteNoteInitial());
    });

    blocTest<DeleteNoteCubit, DeleteNoteState>(
      'should execute delete note when function called',
      build: () {
        when(mockDeleteNote.execute(tId)).thenAnswer(
            (_) async => const Right(Constants.successDeleteNoteMsg));
        return cubit;
      },
      act: (cubit) => cubit.deleteNote(tId),
      verify: (cubit) => mockDeleteNote.execute(tId),
    );

    blocTest<DeleteNoteCubit, DeleteNoteState>(
      'should emits [Loading, Success] when delete note successfully',
      build: () {
        when(mockDeleteNote.execute(tId)).thenAnswer(
            (_) async => const Right(Constants.successDeleteNoteMsg));
        return cubit;
      },
      act: (cubit) => cubit.deleteNote(tId),
      expect: () => [
        DeleteNoteLoading(),
        const DeleteNoteSuccess(message: Constants.successDeleteNoteMsg),
      ],
    );

    blocTest<DeleteNoteCubit, DeleteNoteState>(
      'should emits [Loading, Success] when delete note successfully',
      build: () {
        when(mockDeleteNote.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.deleteNote(tId),
      expect: () => [
        DeleteNoteLoading(),
        const DeleteNoteFailed(message: 'Server Error'),
      ],
    );
  });
}
