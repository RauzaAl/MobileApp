class Todo{
  int? id;
  final String title;
  DateTime creationDate;
  bool isChecked;

  //constructor
  Todo(
    {
      this.id,
      required this.title,
      required this.creationDate,
      required this.isChecked,
    }
  );

  //to save this data in db, need to convert data to map.
  //create this function
  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'creationDate' : creationDate.toString(), //sqflite doesn't support datetime format
      'isChecked' : isChecked ? 1 : 0, //it doesn't support the boolean either, so saved like integer
    };
  }

  //this function is for debugging only
  @override
  String toString() {
    return 'Todo(id : $id, title : $title, creationDate : $creationDate, isChecked : $isChecked)';
  }
}

