import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:artlens/models/artwork.dart';

class ArtworkDb {
  static final ArtworkDb instance = ArtworkDb._init();
  static Database? _database;

  ArtworkDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('artwork.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE artworks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        artist TEXT NOT NULL,
        date TEXT NOT NULL,
        description TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        location TEXT NOT NULL, -- JSON
        informationLink TEXT NOT NULL,
        timestamp INTEGER NOT NULL,
        isFavorite INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<void> insertArtwork(Artwork artwork) async {
    final db = await database;
    await db.insert(
      'artworks',
      artwork.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await deleteOldestIfLimitExceeded();
  }

  Future<List<Artwork>> artworks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('artworks');

    return maps.map((map) => Artwork.fromMap(map)).toList();
  }

  Future<List<Artwork>> searchArtworks(String query) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'artworks',
      where: 'title LIKE ? OR artist LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );

    return maps.map((map) => Artwork.fromMap(map)).toList();
  }

  Future<List<Artwork>> searchFavoriteArtworks(String query) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'artworks',
      where: '(title LIKE ? OR artist LIKE ?) AND isFavorite = 1',
      whereArgs: ['%$query%', '%$query%'],
    );

    return maps.map((map) => Artwork.fromMap(map)).toList();
  }

  Future<void> toggleFavorite(String artworkId, bool isFavorite) async {
    final db = await database;
    await db.update(
      'artworks',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [artworkId],
    );
  }

  Future<void> deleteOldestIfLimitExceeded() async {
    final db = await database;

    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM artworks'),
    );

    const int maxEntries = 50;

    if (count != null && count > maxEntries) {
      final numberToDelete = count - maxEntries;

      await db.rawDelete(
        '''
        DELETE FROM artworks 
        WHERE id IN (
          SELECT id FROM artworks 
          ORDER BY timestamp ASC 
          LIMIT ?
        )
      ''',
        [numberToDelete],
      );
    }
  }

  Future<List<Artwork>> getAllArtworks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'artworks',
      orderBy: 'timestamp DESC', // Mostra le scansioni più recenti prima
    );
    return maps.map((map) => Artwork.fromMap(map)).toList();
  }

  Future<void> addToFavorites(String artworkId) async {
    final db = await database;
    await db.update(
      'artworks',
      {'isFavorite': 1},
      where: 'id = ?',
      whereArgs: [artworkId],
    );
  }
}
