import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proyek_6/models/notes.dart';
import 'package:proyek_6/services/repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  
  final NoteRepos noteRepos;

  NotesBloc({required this.noteRepos}) : super(NotesInitial()) {
   on<ShowNotes>(_getAllNotes);
   on<AddNotes>(_addNotes);
   on<UpdateNotes>(_updateNotes);
   on<DeleteNotes>(_deleteNotes);
  }

  FutureOr<void> _getAllNotes(ShowNotes event, Emitter<NotesState> emit) async {
    List<Note> notes = await NoteRepos.readAllNotes();
    emit(NotesLoaded(notes: notes));

  }

  FutureOr<void> _addNotes(AddNotes event, Emitter<NotesState> emit) async {
    List<Note> notes = await NoteRepos.readAllNotes();
    
    if (state is NotesLoaded){
      await NoteRepos.createNote(event.note);
      emit(NotesLoaded(notes: notes));
    }
  }

  FutureOr<void> _updateNotes(UpdateNotes event, Emitter<NotesState> emit) async {
  List<Note> notes = await NoteRepos.readAllNotes();
   
   if (state is NotesLoaded){
    await NoteRepos.updateNotes(event.note);
      emit(NotesLoaded(notes: notes));

   }
  }

  FutureOr<void> _deleteNotes(DeleteNotes event, Emitter<NotesState> emit) async {
    List <Note> notes = await NoteRepos.readAllNotes();

    if (state is NotesLoaded){
      await NoteRepos.deleteNotes(event.note.id!);
      emit(NotesLoaded(notes: notes));
    }

  }
}
