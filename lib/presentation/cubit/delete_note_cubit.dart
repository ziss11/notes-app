import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viapulsa_test/domain/usecases/delete_note.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  final DeleteNote _deleteNote;

  DeleteNoteCubit(this._deleteNote) : super(DeleteNoteInitial());

  void deleteNote(String id) async {
    emit(DeleteNoteLoading());

    final result = await _deleteNote.execute(id);
    result.fold(
      (failure) => emit(DeleteNoteFailed(message: failure.message)),
      (message) => emit(DeleteNoteSuccess(message: message)),
    );
  }
}
