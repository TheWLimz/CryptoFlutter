import 'package:proyek_6/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';


class DatabaseServices {
   static final DatabaseServices instance = DatabaseServices._init();
   
   static Database? _database;
   
   DatabaseServices._init();

   Future<Database> get database async{
     if (_database != null) return _database!;
     _database = await _initDB('wish.db');
     return _database!;
   }

   Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filepath;

    return await openDatabase(path, version: 1, onCreate: _createDB);

   }

   Future<void> _createDB(Database db, int version) async{
   
   final String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
 
    await db.execute('''
    CREATE TABLE $tableNotes(
     ${NoteFields.id} $idType,
     ${NoteFields.title} TEXT NOT NULL,
     ${NoteFields.number} INTEGER NOT NULL,
     ${NoteFields.description} TEXT NOT NULL,
     ${NoteFields.createdAt} TEXT NOT NULL

    )
''');
   }


   Future<void> closeDatabase() async {
    final db = await instance.database;

    db.close();
   }
   
}