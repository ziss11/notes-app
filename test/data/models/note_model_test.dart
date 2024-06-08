import 'package:flutter_test/flutter_test.dart';
import 'package:viapulsa_test/data/models/note_model.dart';

import '../../dummy_data/dummy_object.dart';

void main() {
  final tMovieJson = {
    'id': 'id',
    'title': 'title',
    'description': 'description',
    'createdAt': DateTime(2024).toIso8601String(),
    'updatedAt': DateTime(2024).toIso8601String(),
  };

  test('should return a valid model from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap = tMovieJson;
    // act
    final result = NoteModel.fromJson(jsonMap);
    // assert
    expect(result, tNoteModel);
  });
}
