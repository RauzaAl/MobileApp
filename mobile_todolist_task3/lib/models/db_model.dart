import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './todo_model.dart';


class DatabaseConnect{
  Database? _database;

  //create a getter and open a connection to db
  Future<Database> get database async {
    //this is the location of our db in pc
    final dbpath = await getDatabasesPath();
    //the name of db
    const dbname = 'todo.db';
    //this joins the dbpath and dbname and create a full path for db
    final path = join(dbpath, dbname);

    //open the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    //will create the _createDB function separately

    return _database!;
  }

  //the _create db function
  //this function creates Tables in our database
    Future<void> _createDB(Database db, int version) async {
      await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
    }

  //function to add data into our db
  Future<void> insertTodo(Todo todo) async {
      //get the connection to db
      final db = await database;
      //insert the todo
      await db.insert(
        'todo',     //the name of our table
        todo.toMap(),   //the function we created in our todo_model
        conflictAlgorithm: ConflictAlgorithm.replace,   //this will replace the duplicate entry
      );
  }

  //function to delete data from our db
  Future<void> deleteTodo(Todo todo) async {
      final db = await database;
      //delete the todo from db based on its id
      await db.delete(
        'todo',
        where: 'id == ?',     //this condition will check for id
        whereArgs: [todo.id],
      );
  }

  //function to fetch all the todo data from our db
  Future<List<Todo>> getTodo() async {
      final db = await database;
      //query the db and save the todo as list of maps
      List<Map<String, dynamic>> items = await db.query(
        'todo',
        orderBy: 'id DESC',  //this will order the list by id in DESC ordering
        //the latest todo will displayed on top

      );

      //now convert the items from lists of map to list of todo

      return List.generate(
        items.length,
        (i) => Todo(
          id: items[i]['id'],
          title: items[i]['title'],
          creationDate: DateTime.parse(items[i][
            'creationDate']), //this in TEXT format right now. need to convert it to dateTime format
          isChecked: items[i]['isChecked'] == 1 ? true : false, //this will convert the Integer to boolean: 1 = true, 0 = false
        ),
      );
  }
}




