import 'package:viapulsa_test/common/exceptions.dart';
import 'package:viapulsa_test/data/datasources/db/database_helper.dart';
import 'package:viapulsa_test/data/models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<void> cacheNotes(List<NoteModel> notes);
  Future<int> clearCacheNotes();
  Future<List<NoteModel>> getCachedNotes();
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final DatabaseHelper _databaseHelper;

  const NoteLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheNotes(List<NoteModel> notes) async {
    await _databaseHelper.clearCache();
    await _databaseHelper.insertCacheTransaction(notes);
  }

  @override
  Future<int> clearCacheNotes() async {
    return await _databaseHelper.clearCache();
  }

  @override
  Future<List<NoteModel>> getCachedNotes() async {
    final result = await _databaseHelper.getCachedNotes();

    if (result.isNotEmpty) {
      return result.map((data) => NoteModel.fromJson(data)).toList();
    } else {
      throw CacheException();
    }
  }
}
