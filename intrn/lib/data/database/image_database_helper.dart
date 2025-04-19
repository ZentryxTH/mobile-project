import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ImageDatabaseHelper {
  static const _databaseName = "imageDatabase.db";
  static const _databaseVersion = 1;
  static const imageTable = 'imageTable';
  static const columnId = 'id';
  static const columnImageUrl = 'imageUrl';

  // Singleton instance of the DatabaseHelper
  static final ImageDatabaseHelper instance = ImageDatabaseHelper._init();

  // Private constructor for singleton pattern
  ImageDatabaseHelper._init();

  // Database instance
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the image table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $imageTable (
        $columnId TEXT PRIMARY KEY,
        $columnImageUrl TEXT
      )
    ''');
  }

  // Insert the image URL into the database
  Future<int> insertImage(String userId, String imageUrl) async {
    final db = await instance.database;

    // Ensure imageUrl is not null by using an empty string if null
    final safeImageUrl = imageUrl.isEmpty ? '' : imageUrl;

    // Insert data into the database
    return await db.insert(
      imageTable,
      {
        columnId: userId,
        columnImageUrl: safeImageUrl, // Use safeImageUrl (non-null)
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts if necessary
    );
  }


  // Get image URL by user ID
  Future<String?> getImageUrlByUserId(String userId) async {
    final db = await instance.database;
    final result = await db.query(imageTable, where: '$columnId = ?', whereArgs: [userId]);
    if (result.isNotEmpty) {
      return result.first[columnImageUrl] as String;
    }
    return null;
  }
}