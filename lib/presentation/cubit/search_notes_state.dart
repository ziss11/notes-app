part of 'search_notes_cubit.dart';

sealed class SearchNotesState extends Equatable {
  const SearchNotesState();

  @override
  List<Object> get props => [];
}

final class SearchNotesInitial extends SearchNotesState {}

final class SearchNotesLoading extends SearchNotesState {}

final class SearchNotesLoaded extends SearchNotesState {
  final List<Note> notes;

  const SearchNotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

final class SearchNotesFailed extends SearchNotesState {
  final String message;

  const SearchNotesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
