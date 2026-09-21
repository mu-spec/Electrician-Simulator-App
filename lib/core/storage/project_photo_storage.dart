import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Permanent on-device storage for Job Manager project (site) photos.
///
/// `image_picker` hands back a path inside a temporary/cache directory that the
/// operating system is free to purge at any time. A capture is therefore copied
/// into this store before its path is written to the `project_photos` table, so
/// saved photos survive app restarts and OS cache clean-ups.
///
/// Layout: `<application documents>/project_photos/<projectId>/<fileName>`
class ProjectPhotoStorage {
  ProjectPhotoStorage._();

  /// Folder, relative to the application documents directory, holding the
  /// per-project photo folders.
  static const String rootFolderName = 'project_photos';

  /// Used when a captured file carries no usable extension.
  static const String fallbackExtension = '.jpg';

  static final Random _random = Random();

  static final RegExp _safeExtensionPattern = RegExp(r'^\.[a-z0-9]{1,5}$');

  /// The root folder holding every project's photo folder.
  ///
  /// Not created here; callers create what they need.
  static Future<Directory> _rootDirectory() async {
    final base = await getApplicationDocumentsDirectory();
    return Directory(p.join(base.path, rootFolderName));
  }

  /// Returns (creating it when needed) the folder holding [projectId] photos.
  static Future<Directory> projectPhotoDirectory(int projectId) async {
    final root = await _rootDirectory();
    final directory = Directory(p.join(root.path, projectId.toString()));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  /// Copies [sourcePath] into permanent storage and returns the stored path.
  ///
  /// Callers must persist the returned path; if that persistence step fails
  /// they should discard the copy with [deletePhotoFile] so no orphan file is
  /// left behind.
  static Future<String> persistProjectPhoto({
    required int projectId,
    required String sourcePath,
  }) async {
    final directory = await projectPhotoDirectory(projectId);
    final storedPath = p.join(directory.path, _buildUniqueFileName(sourcePath));
    try {
      await File(sourcePath).copy(storedPath);
    } catch (_) {
      // A copy that fails midway must not leave a half-written file behind.
      await deletePhotoFile(storedPath);
      rethrow;
    }
    return storedPath;
  }

  /// Deletes the file at [path] when it exists. Never throws.
  ///
  /// Paths recorded before permanent storage existed point at temporary files
  /// that may already have been purged, so a missing file is not an error.
  static Future<void> deletePhotoFile(String? path) async {
    if (path == null || path.isEmpty) return;
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } on FileSystemException {
      // Already gone or no longer reachable. Removing a photo must never crash
      // the UI.
    }
  }

  /// Removes every stored photo for [projectId], folder included, so deleting
  /// a project leaves no orphan files behind.
  ///
  /// Note this removes only `project_photos/<projectId>/`; the shared
  /// `project_photos` root directory stays in place for other projects. Use
  /// [deleteAllProjectPhotos] to remove the root itself.
  ///
  /// Best effort by design: a filesystem problem here must not block the
  /// database side of deleting a project.
  static Future<void> deleteProjectPhotoDirectory(int projectId) async {
    try {
      final root = await _rootDirectory();
      final directory = Directory(p.join(root.path, projectId.toString()));
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    } on FileSystemException {
      // Nothing stored for this project, or the folder was removed outside the
      // app. Deleting a project must never crash.
    }
  }

  /// Removes the whole `project_photos` root directory, every project's photos
  /// included. Used when the user clears all app data.
  ///
  /// A missing directory is not an error. Best effort by design: a filesystem
  /// problem here must not crash the app or block the database cleanup.
  static Future<void> deleteAllProjectPhotos() async {
    try {
      final root = await _rootDirectory();
      if (await root.exists()) {
        await root.delete(recursive: true);
      }
    } on FileSystemException {
      // Never stored a photo, or the root was already removed. Clearing app
      // data must never crash.
    }
  }

  /// `photo_<microseconds>_<random-hex><ext>` — unique per capture without an
  /// extra plugin, and collision-free even for photos taken in the same
  /// millisecond by different projects or screens.
  static String _buildUniqueFileName(String sourcePath) {
    final extension = _safeExtension(sourcePath);
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final entropy =
        _random.nextInt(0x7fffffff).toRadixString(16).padLeft(8, '0');
    return 'photo_${timestamp}_$entropy$extension';
  }

  /// Keeps a plausible image extension (`.jpg`, `.png`, `.heic`, ...) from the
  /// picked file and falls back to [fallbackExtension] otherwise.
  static String _safeExtension(String sourcePath) {
    final extension = p.extension(sourcePath).toLowerCase();
    if (!_safeExtensionPattern.hasMatch(extension)) return fallbackExtension;
    return extension;
  }
}
