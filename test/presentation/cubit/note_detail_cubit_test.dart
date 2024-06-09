import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/domain/usecases/get_note_by_id.dart';
import 'package:viapulsa_test/presentation/cubit/note_detail_cubit.dart';

import '../../dummy_data/dummy_object.dart';
import 'note_detail_cubit_test.mocks.dart';

@GenerateMocks([GetNoteById])
void main() {
  late NoteDetailCubit cubit;
  late MockGetNoteById mockGetNoteById;

  setUp(() {
    mockGetNoteById = MockGetNoteById();
    cubit = NoteDetailCubit(mockGetNoteById);
  });

  group('Note Detail Cubit', () {
    const tId = 'id';

    test('initialState should be Empty', () {
      expect(cubit.state, NoteDetailInitial());
    });

    blocTest<NoteDetailCubit, NoteDetailState>(
      'should execute get note by id when function is called',
      build: () {
        when(mockGetNoteById.execute(tId))
            .thenAnswer((_) async => Right(tNote));
        return cubit;
      },
      act: (cubit) => cubit.getNoteDetail(tId),
      verify: (cubit) => mockGetNoteById.execute(tId),
    );

    blocTest<NoteDetailCubit, NoteDetailState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNoteById.execute(tId))
            .thenAnswer((_) async => Right(tNote));
        return cubit;
      },
      act: (cubit) => cubit.getNoteDetail(tId),
      expect: () => [
        NoteDetailLoading(),
        NoteDetailLoaded(note: tNote),
      ],
    );

    blocTest<NoteDetailCubit, NoteDetailState>(
      'should emit [Loading, Failure] when data is gotten successfully',
      build: () {
        when(mockGetNoteById.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.getNoteDetail(tId),
      expect: () => [
        NoteDetailLoading(),
        const NoteDetailFailed(message: 'Server Error'),
      ],
    );
  });
}
