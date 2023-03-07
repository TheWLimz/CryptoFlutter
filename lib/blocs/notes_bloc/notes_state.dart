part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
  
  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState{
   
   List<Note> notes;
   
   NotesLoaded({required this.notes});
   
  @override 
  List<Object> get props => [notes];
}


