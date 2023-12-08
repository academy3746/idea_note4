import 'package:idea_note4/data/idea_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database db;

  /// 0. OPEN DATABASE
  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), "idea_note.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute("""
          CREATE TABLE IF NOT EXISTS write_idea (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            motive TEXT,
            content TEXT,
            importance INTEGER,
            feedback TEXT,
            createDatetime INTEGER
          )
        """);
      },
    );
  }

  /// 1. CREATE
  Future<int> insertIdeaInfo(IdeaInfo idea) async {
    return await db.insert("write_idea", idea.toJson());
  }

  /// 2. READ
  Future<List<IdeaInfo>> getAllIdeaInfo() async {
    final List<Map<String, dynamic>> data = await db.query("write_idea");

    return List.generate(data.length, (index) {
      return IdeaInfo.fromJson(data[index]);
    });
  }

  /// 3. UPDATE
  Future<int> updateIdeaInfo(IdeaInfo idea) async {
    return await db.update(
      "write_idea",
      idea.toJson(),
      where: "id = ?",
      whereArgs: [idea.id],
    );
  }

  /// 4. DELETE
  Future<int> deleteIdeaInfo(int id) async {
    return await db.delete(
      "write_idea",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// 5. EXIT DATABASE
  Future<void> exitDatabase() async {
    await db.close();
  }
}
