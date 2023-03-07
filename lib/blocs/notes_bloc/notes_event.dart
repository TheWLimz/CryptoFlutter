part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesEvent{}

class ShowNotes extends NotesEvent {
  final List<Note> notes;

  const ShowNotes({this.notes = const<Note>[]});
}

class AddNotes extends NotesEvent{
   final Note note;

   const AddNotes({required this.note});

   @override
  List<Object> get props => [note];
}

class UpdateNotes extends NotesEvent {
  final Note note;

  const UpdateNotes({required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteNotes extends NotesEvent {
  final Note note;

  const DeleteNotes({required this.note});

  @override
  List<Object> get props => [note];
}

