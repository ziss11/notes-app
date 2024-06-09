part of 'note_detail_cubit.dart';

sealed class NoteDetailState extends Equatable {
  const NoteDetailState();

  @override
  List<Object> get props => [];
}

final class NoteDetailInitial extends NoteDetailState {}

final class NoteDetailLoading extends NoteDetailState {}

final class NoteDetailLoaded extends NoteDetailState {
  final Note note;

  const NoteDetailLoaded({required this.note});

  @override
  List<Object> get props => [note];
}

final class NoteDetailFailed extends NoteDetailState {
  final String message;

  const NoteDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
