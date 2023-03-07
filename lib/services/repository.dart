import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyek_6/models/portfolio_model.dart';
import 'package:proyek_6/services/db_services.dart';

import '../models/notes.dart';

class NoteRepos{
  
  static final DatabaseServices services = DatabaseServices.instance;

  static Future<Note> createNote(Note note) async {
    final db = await services.database;
    final id = await db.insert(tableNotes,note.toJson());
    return note.copyWith(id : id);
  }
  
  static Future<Note> readNote(int id) async {
    final db = await services.database;
    final maps = await db.query(
      tableNotes,
      columns: ['id', 'title', 'number', 'description', 'createdAt'],
      where : '${NoteFields.id} = ?',
      whereArgs: [id]
    );

    if (maps.isNotEmpty){
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not Found');
    }
  }

  static Future<List<Note>> readAllNotes() async {
     final db = await services.database;
     
     final orderBy = '${NoteFields.createdAt} ASC';
     final result = await db.query(tableNotes, orderBy: orderBy);

     return result.map((json) => Note.fromJson(json)).toList();
  }
  
  static Future<int> updateNotes(Note note) async{
     final db = await services.database;

     return db.update(
    tableNotes, 
     note.toJson(), 
     where: '${NoteFields.id} = ?', 
     whereArgs : [note.id]); 
  }
  
  static Future<int> deleteNotes(int id) async {
    final db = await services.database;

    return await db.delete(
      tableNotes,
      where : '${NoteFields.id} = ?',
      whereArgs: [id]
    );
  }

}

class PortfolioRepos{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

   static Future<List<PortfolioModel>> getAllPortfolios() async{
       var portfolios = firestore.collection("porfolios");
       try{
         var response = await portfolios.get();
         List<PortfolioModel> result = response.docs.map<PortfolioModel>((e) => PortfolioModel.fromJson(e.data())).toList();
         print(result[0].id);
         return result;
       } catch(e){
        print(e);
         throw Exception(e);
       }
   }

   static Future<void> addPortfolios(PortfolioModel data) async {
       var portfolio = firestore.collection("porfolios");
       try{      
        await portfolio.add(data.toMap());
       }catch(e){
        print(e);
          throw Exception(e);
       }
   }

   static Future<void> removePortfolios(String id) async {
    var portfolio = firestore.collection("porfolios");
     try{
      await portfolio.doc(id).delete();
     } catch(e){
       print(e);
      throw Exception(e);
     }
   }


}