part of 'add_note_cubit.dart';

sealed class AddNoteState extends Equatable {
  const AddNoteState();

  @override
  List<Object> get props => [];
}

final class AddNoteInitial extends AddNoteState {}

final class AddNoteLoading extends AddNoteState {}

final class AddNoteSuccess extends AddNoteState {
  final String message;

  const AddNoteSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class AddNoteFailed extends AddNoteState {
  final String message;

  const AddNoteFailed({required this.message});

  @override
  List<Object> get props => [message];
}
