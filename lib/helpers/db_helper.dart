class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "reminders";
  
  static Future<void> initDb() aysnc{
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'reminder.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          print("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, reminder TEXT, date STRING, "
            "time STRING, remindBefore STRING, repeat STRING, "
            "color STRING, isReminded STRING )",
          ); 
        },
      );
    } catch(e){
      print(e);
    }
  }
  static Future<int> insert(Reminder? reminder) aysnc{
    print("insert function called");
    return await _db?.insert(_tableName, reminder!.toJson())??1;
  
  }
}
