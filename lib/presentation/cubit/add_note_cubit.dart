import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viapulsa_test/domain/usecases/add_note.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  final AddNote _addNote;

  AddNoteCubit(this._addNote) : super(AddNoteInitial());

  void addNote(String title, String description) async {
    emit(AddNoteLoading());

    final result = await _addNote.execute(title, description);
    result.fold(
      (failure) => emit(AddNoteFailed(message: failure.message)),
      (message) => emit(AddNoteSuccess(message: message)),
    );
  }
}
