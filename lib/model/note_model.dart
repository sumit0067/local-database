class NoteModel{
  int id;
  int number;
  String title;
  String description;
  String createdTime;

  NoteModel(
    this.id,
    this.number,
    this.title,
    this.description,
    this.createdTime,
  );
  NoteModel.withOutId(
    this.number,
    this.title,
    this.description,
    this.createdTime,
  );


  Map<String,dynamic> toMap(){
   final map = Map<String,dynamic>();
   map['id'] = id;
   map['number'] = number;
   map['title'] = title;
   map['description'] = description;
   map['createdTime'] = createdTime;
  }

  NoteModel.formMap(Map<String,dynamic> map){
    id = map['id'];
    number = map['number'];
    title = map['title'];
    description = map['description'];
    createdTime = map['createdTime'];
  }
}