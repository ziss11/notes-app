import 'package:flutter_test/flutter_test.dart';
import 'package:viapulsa_test/data/models/note_model.dart';

import '../../dummy_data/dummy_object.dart';

void main() {
  final tNoteJson = {
    'id': 'id',
    'title': 'title',
    'description': 'description',
    'createdAt': DateTime(2024).toIso8601String(),
    'updatedAt': DateTime(2024).toIso8601String(),
  };

  test('should return a valid model from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap = tNoteJson;
    // act
    final result = NoteModel.fromJson(jsonMap);
    // assert
    expect(result, tNoteModel);
  });

  test('should return a JSon map containing proper data', () async {
    // act
    final result = tNoteModel.toJson();
    // assert
    final expectedJsonMap = tNoteJson;
    expect(result, expectedJsonMap);
  });

  test('should be a subclass of Note Entity', () {
    // assert
    final result = tNoteModel.toEntity();
    expect(result, tNote);
  });
}
