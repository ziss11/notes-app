import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/usecases/get_note_by_id.dart';

part 'note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailState> {
  final GetNoteById _getNoteById;

  NoteDetailCubit(this._getNoteById) : super(NoteDetailInitial());

  void getNoteDetail(String id) async {
    emit(NoteDetailLoading());

    final result = await _getNoteById.execute(id);
    result.fold(
      (failure) => emit(NoteDetailFailed(message: failure.message)),
      (data) => emit(NoteDetailLoaded(note: data)),
    );
  }
}
