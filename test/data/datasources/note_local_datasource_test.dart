import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/data/datasources/note_local_datasource.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NoteLocalDataSource localDataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    localDataSource = NoteLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('Cached Notes', () {
    test('should return list of cached notes from database', () async {
      // arrange
      when(mockDatabaseHelper.getCachedNotes()).thenAnswer(
        (_) async => tCachedNotesMap,
      );
      // act
      final result = await localDataSource.getCachedNotes();
      // assert
      expect(result, tCachedNotes);
    });

    test('should insert list of cached notes to database', () async {
      // act
      await localDataSource.cacheNotes(tNoteModels);
      // assert
      verify(mockDatabaseHelper.insertCacheTransaction(tNoteModels));
    });

    test('should clear cached notes', () async {
      // arrange
      when(mockDatabaseHelper.clearCache()).thenAnswer((_) async => 1);
      // act
      await localDataSource.clearCacheNotes();
      // assert
      verify(mockDatabaseHelper.clearCache());
    });
  });
}
