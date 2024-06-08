part of 'notes_cubit.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class AllNotesInitial extends NotesState {}

final class AllNotesLoading extends NotesState {}

final class AllNotesLoaded extends NotesState {
  final List<Note> notes;

  const AllNotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

final class AllNotesFailed extends NotesState {
  final String message;

  const AllNotesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
