import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import '../models/certification_track.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static const String dbName = 'voltmaster.db';
  static const int dbVersion = 4;

  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        created_at INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE quiz_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id TEXT NOT NULL,
        score INTEGER NOT NULL,
        total_questions INTEGER NOT NULL,
        time_seconds INTEGER NOT NULL,
        date INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE saved_calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calculator_id TEXT NOT NULL,
        calculator_name TEXT NOT NULL,
        inputs TEXT NOT NULL,
        outputs TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reading_history (
        article_id TEXT PRIMARY KEY,
        read_at INTEGER NOT NULL
      )
    ''');

    await _createNotesTable(db);
    await _createProjectsTable(db);
    await _createProjectItemsTable(db);
    await _createProjectPhotosTable(db);
    await _createProjectCalculationsTable(db);
    await _createProjectChecklistTable(db);
    await _createCertificationProgressTable(db);
  }

  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createNotesTable(db);
      await _createProjectsTable(db);
    }
    if (oldVersion < 3) {
      await _createProjectItemsTable(db);
      await _createProjectPhotosTable(db);
      await _createProjectCalculationsTable(db);
      await _createProjectChecklistTable(db);
    }
    if (oldVersion < 4) {
      await _createCertificationProgressTable(db);
    }
  }

  static Future<void> _createNotesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS notes (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        note TEXT NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _createProjectsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS projects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        client TEXT NOT NULL,
        phone TEXT DEFAULT '',
        site TEXT NOT NULL,
        status TEXT NOT NULL,
        priority TEXT DEFAULT 'Normal',
        job_type TEXT DEFAULT 'General Electrical',
        start_date INTEGER DEFAULT 0,
        due_date INTEGER DEFAULT 0,
        notes TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    await _safeAddColumn(db, 'projects', 'phone', "TEXT DEFAULT ''");
    await _safeAddColumn(db, 'projects', 'priority', "TEXT DEFAULT 'Normal'");
    await _safeAddColumn(db, 'projects', 'job_type', "TEXT DEFAULT 'General Electrical'");
    await _safeAddColumn(db, 'projects', 'start_date', 'INTEGER DEFAULT 0');
    await _safeAddColumn(db, 'projects', 'due_date', 'INTEGER DEFAULT 0');
  }

  static Future<void> _createProjectItemsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS project_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        project_id INTEGER NOT NULL,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        unit_price REAL NOT NULL,
        notes TEXT DEFAULT '',
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _createProjectPhotosTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS project_photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        project_id INTEGER NOT NULL,
        path TEXT NOT NULL,
        caption TEXT DEFAULT '',
        created_at INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _createProjectCalculationsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS project_calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        project_id INTEGER NOT NULL,
        calculation_id INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        UNIQUE(project_id, calculation_id)
      )
    ''');
  }

  static Future<void> _createProjectChecklistTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS project_checklist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        project_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        is_done INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _createCertificationProgressTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS certification_progress (
        track_id TEXT PRIMARY KEY,
        completed_modules TEXT NOT NULL DEFAULT '',
        best_score INTEGER NOT NULL DEFAULT 0,
        attempts INTEGER NOT NULL DEFAULT 0,
        last_attempt_at INTEGER NOT NULL DEFAULT 0,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _safeAddColumn(Database db, String table, String column, String definition) async {
    try {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $definition');
    } catch (_) {
      // Column already exists.
    }
  }

  // Bookmarks
  static Future<void> addBookmark(String id, String type) async {
    final db = await database;
    await db.insert('bookmarks', {
      'id': id,
      'type': type,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeBookmark(String id) async {
    final db = await database;
    await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<String>> getBookmarks(String type) async {
    final db = await database;
    final result = await db.query('bookmarks', columns: ['id'], where: 'type = ?', whereArgs: [type]);
    return result.map((e) => e['id'] as String).toList();
  }

  static Future<bool> isBookmarked(String id) async {
    final db = await database;
    final result = await db.query('bookmarks', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  // Notes
  static Future<void> saveNote(String id, String type, String note) async {
    final db = await database;
    if (note.trim().isEmpty) {
      await db.delete('notes', where: 'id = ? AND type = ?', whereArgs: [id, type]);
      return;
    }
    await db.insert('notes', {
      'id': id,
      'type': type,
      'note': note.trim(),
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<String?> getNote(String id, String type) async {
    final db = await database;
    final result = await db.query('notes', where: 'id = ? AND type = ?', whereArgs: [id, type], limit: 1);
    if (result.isEmpty) return null;
    return result.first['note'] as String?;
  }

  static Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await database;
    return await db.query('notes', orderBy: 'updated_at DESC');
  }

  // Quiz Results
  static Future<void> saveQuizResult(Map<String, dynamic> result) async {
    final db = await database;
    await db.insert('quiz_results', {...result, 'date': DateTime.now().millisecondsSinceEpoch});
  }

  static Future<List<Map<String, dynamic>>> getQuizResults(String categoryId) async {
    final db = await database;
    return await db.query('quiz_results', where: 'category_id = ?', whereArgs: [categoryId], orderBy: 'date DESC');
  }

  // Saved Calculations
  static Future<void> saveCalculation(Map<String, dynamic> calc) async {
    final db = await database;
    await db.insert('saved_calculations', {...calc, 'created_at': DateTime.now().millisecondsSinceEpoch});
  }

  static Future<List<Map<String, dynamic>>> getSavedCalculations() async {
    final db = await database;
    return await db.query('saved_calculations', orderBy: 'created_at DESC');
  }

  static Future<void> deleteSavedCalculation(int id) async {
    final db = await database;
    await db.delete('saved_calculations', where: 'id = ?', whereArgs: [id]);
    await db.delete('project_calculations', where: 'calculation_id = ?', whereArgs: [id]);
  }

  // Projects / Advanced Job Manager
  static Future<int> saveProject(Map<String, dynamic> project) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = project['id'] as int?;
    final data = {
      'name': project['name'] ?? '',
      'client': project['client'] ?? '',
      'phone': project['phone'] ?? '',
      'site': project['site'] ?? '',
      'status': project['status'] ?? 'Open',
      'priority': project['priority'] ?? 'Normal',
      'job_type': project['job_type'] ?? 'General Electrical',
      'start_date': project['start_date'] ?? 0,
      'due_date': project['due_date'] ?? 0,
      'notes': project['notes'] ?? '',
      'updated_at': now,
    };
    if (id == null) {
      return await db.insert('projects', {...data, 'created_at': now});
    }
    await db.update('projects', data, where: 'id = ?', whereArgs: [id]);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getProjects() async {
    final db = await database;
    return await db.query('projects', orderBy: 'updated_at DESC');
  }

  static Future<Map<String, dynamic>?> getProject(int id) async {
    final db = await database;
    final result = await db.query('projects', where: 'id = ?', whereArgs: [id], limit: 1);
    if (result.isEmpty) return null;
    return result.first;
  }

  static Future<void> deleteProject(int id) async {
    final db = await database;
    await db.delete('projects', where: 'id = ?', whereArgs: [id]);
    await db.delete('project_items', where: 'project_id = ?', whereArgs: [id]);
    await db.delete('project_photos', where: 'project_id = ?', whereArgs: [id]);
    await db.delete('project_calculations', where: 'project_id = ?', whereArgs: [id]);
    await db.delete('project_checklist', where: 'project_id = ?', whereArgs: [id]);
  }

  static Future<int> saveProjectItem(Map<String, dynamic> item) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = item['id'] as int?;
    final data = {
      'project_id': item['project_id'],
      'type': item['type'] ?? 'material',
      'name': item['name'] ?? '',
      'quantity': item['quantity'] ?? 0.0,
      'unit': item['unit'] ?? 'pcs',
      'unit_price': item['unit_price'] ?? 0.0,
      'notes': item['notes'] ?? '',
      'updated_at': now,
    };
    if (id == null) {
      return await db.insert('project_items', {...data, 'created_at': now});
    }
    await db.update('project_items', data, where: 'id = ?', whereArgs: [id]);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getProjectItems(int projectId) async {
    final db = await database;
    return await db.query('project_items', where: 'project_id = ?', whereArgs: [projectId], orderBy: 'type ASC, name ASC');
  }

  static Future<void> deleteProjectItem(int id) async {
    final db = await database;
    await db.delete('project_items', where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, double>> getProjectTotals(int projectId) async {
    final items = await getProjectItems(projectId);
    double material = 0;
    double labor = 0;
    for (final item in items) {
      final qty = (item['quantity'] as num?)?.toDouble() ?? 0;
      final price = (item['unit_price'] as num?)?.toDouble() ?? 0;
      if (item['type'] == 'labor') {
        labor += qty * price;
      } else {
        material += qty * price;
      }
    }
    return {'material': material, 'labor': labor, 'total': material + labor};
  }

  static Future<int> addProjectPhoto(int projectId, String path, {String caption = ''}) async {
    final db = await database;
    return await db.insert('project_photos', {
      'project_id': projectId,
      'path': path,
      'caption': caption,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<List<Map<String, dynamic>>> getProjectPhotos(int projectId) async {
    final db = await database;
    return await db.query('project_photos', where: 'project_id = ?', whereArgs: [projectId], orderBy: 'created_at DESC');
  }

  static Future<void> deleteProjectPhoto(int id) async {
    final db = await database;
    await db.delete('project_photos', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> addChecklistItem(int projectId, String title) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    return await db.insert('project_checklist', {
      'project_id': projectId,
      'title': title,
      'is_done': 0,
      'created_at': now,
      'updated_at': now,
    });
  }

  static Future<List<Map<String, dynamic>>> getChecklistItems(int projectId) async {
    final db = await database;
    return await db.query('project_checklist', where: 'project_id = ?', whereArgs: [projectId], orderBy: 'id ASC');
  }

  static Future<void> setChecklistDone(int id, bool done) async {
    final db = await database;
    await db.update('project_checklist', {
      'is_done': done ? 1 : 0,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteChecklistItem(int id) async {
    final db = await database;
    await db.delete('project_checklist', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> attachCalculationToProject(int projectId, int calculationId) async {
    final db = await database;
    await db.insert('project_calculations', {
      'project_id': projectId,
      'calculation_id': calculationId,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<void> detachCalculationFromProject(int projectId, int calculationId) async {
    final db = await database;
    await db.delete('project_calculations', where: 'project_id = ? AND calculation_id = ?', whereArgs: [projectId, calculationId]);
  }

  static Future<List<Map<String, dynamic>>> getProjectCalculations(int projectId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT saved_calculations.* FROM saved_calculations
      INNER JOIN project_calculations ON project_calculations.calculation_id = saved_calculations.id
      WHERE project_calculations.project_id = ?
      ORDER BY project_calculations.created_at DESC
    ''', [projectId]);
  }

  static String encodeMap(Map<String, dynamic> map) => jsonEncode(map);

  // Certification Tracks
  static Future<CertificationProgress> getCertificationProgress(String trackId) async {
    final db = await database;
    final result = await db.query('certification_progress', where: 'track_id = ?', whereArgs: [trackId], limit: 1);
    if (result.isEmpty) return CertificationProgress(trackId: trackId);
    final row = result.first;
    final completed = (row['completed_modules'] as String? ?? '')
        .split(',')
        .where((value) => value.trim().isNotEmpty)
        .toList();
    final lastAttempt = row['last_attempt_at'] as int? ?? 0;
    return CertificationProgress(
      trackId: trackId,
      completedModuleIds: completed,
      bestScore: row['best_score'] as int? ?? 0,
      attempts: row['attempts'] as int? ?? 0,
      lastAttemptAt: lastAttempt > 0 ? DateTime.fromMillisecondsSinceEpoch(lastAttempt) : null,
    );
  }

  static Future<Map<String, CertificationProgress>> getCertificationProgressMap() async {
    final db = await database;
    final rows = await db.query('certification_progress');
    final map = <String, CertificationProgress>{};
    for (final row in rows) {
      final trackId = row['track_id'] as String;
      final completed = (row['completed_modules'] as String? ?? '')
          .split(',')
          .where((value) => value.trim().isNotEmpty)
          .toList();
      final lastAttempt = row['last_attempt_at'] as int? ?? 0;
      map[trackId] = CertificationProgress(
        trackId: trackId,
        completedModuleIds: completed,
        bestScore: row['best_score'] as int? ?? 0,
        attempts: row['attempts'] as int? ?? 0,
        lastAttemptAt: lastAttempt > 0 ? DateTime.fromMillisecondsSinceEpoch(lastAttempt) : null,
      );
    }
    return map;
  }

  static Future<void> setCertificationModuleCompleted(String trackId, String moduleId, bool completed) async {
    final db = await database;
    final progress = await getCertificationProgress(trackId);
    final modules = progress.completedModuleIds.toSet();
    if (completed) {
      modules.add(moduleId);
    } else {
      modules.remove(moduleId);
    }
    await db.insert('certification_progress', {
      'track_id': trackId,
      'completed_modules': modules.join(','),
      'best_score': progress.bestScore,
      'attempts': progress.attempts,
      'last_attempt_at': progress.lastAttemptAt?.millisecondsSinceEpoch ?? 0,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> incrementCertificationAttempt(String trackId) async {
    final db = await database;
    final progress = await getCertificationProgress(trackId);
    await db.insert('certification_progress', {
      'track_id': trackId,
      'completed_modules': progress.completedModuleIds.join(','),
      'best_score': progress.bestScore,
      'attempts': progress.attempts + 1,
      'last_attempt_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateCertificationBestScore(String trackId, int scorePercent) async {
    final db = await database;
    final progress = await getCertificationProgress(trackId);
    final best = scorePercent > progress.bestScore ? scorePercent : progress.bestScore;
    await db.insert('certification_progress', {
      'track_id': trackId,
      'completed_modules': progress.completedModuleIds.join(','),
      'best_score': best,
      'attempts': progress.attempts,
      'last_attempt_at': progress.lastAttemptAt?.millisecondsSinceEpoch ?? 0,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Reading History
  static Future<void> markArticleRead(String articleId) async {
    final db = await database;
    await db.insert('reading_history', {'article_id': articleId, 'read_at': DateTime.now().millisecondsSinceEpoch}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<String>> getReadingHistory() async {
    final db = await database;
    final result = await db.query('reading_history', orderBy: 'read_at DESC');
    return result.map((e) => e['article_id'] as String).toList();
  }

  // Clear all user data
  static Future<void> clearAllData() async {
    final db = await database;
    await db.delete('bookmarks');
    await db.delete('quiz_results');
    await db.delete('saved_calculations');
    await db.delete('reading_history');
    await db.delete('notes');
    await db.delete('projects');
    await db.delete('project_items');
    await db.delete('project_photos');
    await db.delete('project_calculations');
    await db.delete('project_checklist');
    await db.delete('certification_progress');
  }
}
