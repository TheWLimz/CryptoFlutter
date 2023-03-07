import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/notes_bloc/notes_bloc.dart';
import '../models/notes.dart';



class AddNotesPage extends StatelessWidget {
   String? notes;
   String? description;
   AddNotesPage({Key? key, this.notes, this.description}) : super(key: key);

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : const Text('Add Notes', style : TextStyle(fontSize: 26)), centerTitle: true,
       backgroundColor: Colors.white,
       foregroundColor: Colors.black,
       toolbarHeight: 80,
      ),
      body : Container(
        padding : const EdgeInsets.all(8),
        margin : const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                width: 450,
                child: TextField(
                  controller: _title,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Add Title'),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                width: 450,
                child: TextFormField(
                  controller: _description,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Add Description'),
                ),
              ),
              const SizedBox(height: 30),
              
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  Note note = Note(
                    title: _title.text,
                    description: _description.text,
                    createdAt: DateTime.now(),
                    number : 1
                  );
                  
                  context.read<NotesBloc>().add(AddNotes(note: note));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    primary: Colors.black,),
                child: const Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ))
              
              
        
          ],
        ),
      )
    );
  }
}