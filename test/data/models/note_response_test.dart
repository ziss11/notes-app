import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:viapulsa_test/data/models/note_response.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  test('should return a valid model from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/notes.json'));
    // act
    final result = NoteResponse.fromJson(jsonMap);
    // assert
    expect(result, tNoteResponseModel);
  });

  test('should return a JSon map containing proper data', () async {
    // act
    final result = tNoteResponseModel.toJson();
    // assert
    final expectedJsonMap = {
      'data': [
        {
          'id': 'id',
          'title': 'title',
          'description': 'description',
          'createdAt': DateTime(2024).toIso8601String(),
          'updatedAt': DateTime(2024).toIso8601String(),
        }
      ],
    };
    expect(result, expectedJsonMap);
  });
}
