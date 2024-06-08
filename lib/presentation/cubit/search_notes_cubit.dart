import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/usecases/search_notes.dart';

part 'search_notes_state.dart';

class SearchNotesCubit extends Cubit<SearchNotesState> {
  final SearchNotes _searchNotes;

  SearchNotesCubit(this._searchNotes) : super(SearchNotesInitial());

  void searchNotes(String query) async {
    emit(SearchNotesLoading());

    final result = await _searchNotes.execute(query);
    result.fold(
      (failure) => emit(SearchNotesFailed(message: failure.message)),
      (data) {
        if (data.isNotEmpty) {
          emit(SearchNotesLoaded(notes: data));
        } else {
          emit(SearchNotesInitial());
        }
      },
    );
  }
}
