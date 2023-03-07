final String tableNotes = 'notes';


class NoteFields{
  static final String id = '_id';
  static final String title = 'title';
  static final String number = 'number';
  static final String description = 'description';
  static final String createdAt = 'createdAt';
}


class Note{
  final int? id;
  final String title;
  final int number;
  final String description;
  final DateTime createdAt;
  
  Note({
    this.id,
    required this.title,
    required this.number,
    required this.description,
    required this.createdAt,
  });

  Map<String,Object?> toJson() => {
      NoteFields.id : id,
      NoteFields.title : title,
      NoteFields.description : description,
      NoteFields.number : number,
      NoteFields.createdAt : createdAt.toIso8601String()
  };

  factory Note.fromJson(Map<String, Object?> json){
    return Note(
      id : json[NoteFields.id] as int?,
      title : json[NoteFields.title] as String,
      number : json[NoteFields.number] as int, 
      description: json[NoteFields.description] as String,
      createdAt: DateTime.parse(json[NoteFields.createdAt] as String) 
    );
  }

  Note copyWith({
    int? id,
    String? title, 
    String? description,
    int? number, 
    DateTime? createdAt
  }) {
    return Note(
      id : id ?? this.id,
      title : title ?? this.title,
      number: number ?? this.number,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt
    );
  }
}
