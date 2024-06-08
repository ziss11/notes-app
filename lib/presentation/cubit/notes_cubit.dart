import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/usecases/get_notes.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetNotes _getNotes;

  NotesCubit(this._getNotes) : super(AllNotesInitial());

  void fetchNotes() async {
    emit(AllNotesLoading());

    final result = await _getNotes.execute();
    result.fold(
      (failure) => emit(AllNotesFailed(message: failure.message)),
      (data) => emit(AllNotesLoaded(notes: data)),
    );
  }
}
