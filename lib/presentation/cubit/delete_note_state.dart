part of 'delete_note_cubit.dart';

sealed class DeleteNoteState extends Equatable {
  const DeleteNoteState();

  @override
  List<Object> get props => [];
}

final class DeleteNoteInitial extends DeleteNoteState {}

final class DeleteNoteLoading extends DeleteNoteState {}

final class DeleteNoteSuccess extends DeleteNoteState {
  final String message;

  const DeleteNoteSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteNoteFailed extends DeleteNoteState {
  final String message;

  const DeleteNoteFailed({required this.message});

  @override
  List<Object> get props => [message];
}
