import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viapulsa_test/domain/usecases/edit_note.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  final EditNote _editNote;

  EditNoteCubit(this._editNote) : super(EditNoteInitial());

  void editNote(String id, String title, String description) async {
    emit(EditNoteLoading());

    final result = await _editNote.execute(id, title, description);
    result.fold(
      (failure) => emit(EditNoteFailed(message: failure.message)),
      (message) => emit(EditNoteSuccess(message: message)),
    );
  }
}
