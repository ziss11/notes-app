import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/exceptions.dart';
import 'package:viapulsa_test/data/datasources/note_remote_datasource.dart';
import 'package:viapulsa_test/data/models/note_model.dart';
import 'package:viapulsa_test/data/models/note_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late NoteRemoteDataSource remoteDataSource;
  late MockDio mockDio;

  setUp(() {
    dotenv.testLoad();

    mockDio = MockDio();
    remoteDataSource = NoteRemoteDataSourceImpl(mockDio);
  });

  const tId = 'id';
  const tNoteTitle = 'title';
  const tNoteDescription = 'description';

  group('Get Notes', () {
    final tNotesResponse =
        NoteResponse.fromJson(jsonDecode(readJson('dummy_data/notes.json')))
            .notes;

    test('should return list of notes when the response code is 200', () async {
      // arrange
      when(mockDio.get('${dotenv.env['API_URL']}/notes')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: readJson('dummy_data/notes.json'),
        ),
      );
      // act
      final result = await remoteDataSource.getNotes();
      // assert
      expect(result, tNotesResponse);
    });

    test('should throw a server exception when the response code is 404',
        () async {
      // arrange
      when(mockDio.get('${dotenv.env['API_URL']}/notes')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: 'Not Found',
        ),
      );
      // act
      final result = remoteDataSource.getNotes();
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('Get Note By Id', () {
    final tNoteResponse = NoteModel.fromJson(
        jsonDecode(readJson('dummy_data/note_by_id.json'))['data']);

    test('should return selected note when the response code is 200', () async {
      // arrange
      when(mockDio.get('${dotenv.env['API_URL']}/notes/$tId')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: readJson('dummy_data/note_by_id.json'),
        ),
      );
      // act
      final result = await remoteDataSource.getNoteById(tId);
      // assert
      expect(result, tNoteResponse);
    });

    test('should throw a server exception when the response code is 404',
        () async {
      // arrange
      when(mockDio.get('${dotenv.env['API_URL']}/notes/$tId')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: 'Not Found',
        ),
      );
      // act
      final result = remoteDataSource.getNoteById(tId);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('Add Note', () {
    final tAddNoteResponse =
        jsonDecode(readJson('dummy_data/add_note.json'))['message'] as String;

    test('should return success message when the response code is 201',
        () async {
      // arrange
      when(mockDio.post('${dotenv.env['API_URL']}/notes', data: {
        'title': tNoteTitle,
        'description': tNoteDescription,
      })).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 201,
          data: readJson('dummy_data/add_note.json'),
        ),
      );
      // act
      final result =
          await remoteDataSource.addNote(tNoteTitle, tNoteDescription);
      // assert
      expect(result, tAddNoteResponse);
    });

    test('should throw a server exception when the response code is 404',
        () async {
      // arrange
      when(mockDio.post('${dotenv.env['API_URL']}/notes', data: {
        'title': tNoteTitle,
        'description': tNoteDescription,
      })).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: 'Not Found',
        ),
      );
      // act
      final result = remoteDataSource.addNote(tNoteTitle, tNoteDescription);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('Edit Note', () {
    final tEditNoteResponse =
        jsonDecode(readJson('dummy_data/edit_note.json'))['message'] as String;

    test('should return success message when the response code is 200',
        () async {
      // arrange
      when(mockDio.patch('${dotenv.env['API_URL']}/notes/$tId', data: {
        'title': tNoteTitle,
        'description': tNoteDescription,
      })).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: readJson('dummy_data/edit_note.json'),
        ),
      );
      // act
      final result =
          await remoteDataSource.editNote(tId, tNoteTitle, tNoteDescription);
      // assert
      expect(result, tEditNoteResponse);
    });

    test('should throw a server exception when the response code is 404',
        () async {
      // arrange
      when(mockDio.patch('${dotenv.env['API_URL']}/notes/$tId', data: {
        'title': tNoteTitle,
        'description': tNoteDescription,
      })).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: 'Not Found',
        ),
      );
      // act
      final result =
          remoteDataSource.editNote(tId, tNoteTitle, tNoteDescription);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('Delete Note', () {
    final tDeleteNoteResponse =
        jsonDecode(readJson('dummy_data/delete_note.json'))['message']
            as String;

    test('should return success message when the response code is 200',
        () async {
      // arrange
      when(mockDio.delete('${dotenv.env['API_URL']}/notes/$tId')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: readJson('dummy_data/delete_note.json'),
        ),
      );
      // act
      final result = await remoteDataSource.deleteNote(tId);
      // assert
      expect(result, tDeleteNoteResponse);
    });

    test('should throw a server exception when the response code is 404',
        () async {
      // arrange
      when(mockDio.delete('${dotenv.env['API_URL']}/notes/$tId')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: 'Not Found',
        ),
      );
      // act
      final result = remoteDataSource.deleteNote(tId);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
