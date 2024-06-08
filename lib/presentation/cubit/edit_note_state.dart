part of 'edit_note_cubit.dart';

sealed class EditNoteState extends Equatable {
  const EditNoteState();

  @override
  List<Object> get props => [];
}

final class EditNoteInitial extends EditNoteState {}

final class EditNoteLoading extends EditNoteState {}

final class EditNoteSuccess extends EditNoteState {
  final String message;

  const EditNoteSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class EditNoteFailed extends EditNoteState {
  final String message;

  const EditNoteFailed({required this.message});

  @override
  List<Object> get props => [message];
}
