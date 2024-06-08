import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viapulsa_test/common/exceptions.dart';
import 'package:viapulsa_test/data/models/note_model.dart';
import 'package:viapulsa_test/data/models/note_response.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes();
  Future<List<NoteModel>> searchNotes(String query);
  Future<NoteModel> getNoteById(String id);
  Future<String> addNote(String title, String description);
  Future<String> editNote(String id, String title, String description);
  Future<String> deleteNote(String id);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final Dio _dio;

  const NoteRemoteDataSourceImpl(this._dio);

  @override
  Future<String> addNote(String title, String description) async {
    final response = await _dio.post(
      '${dotenv.env['API_URL']}/notes',
      data: {
        'title': title,
        'description': description,
      },
    );

    if (response.statusCode == 201) {
      final result = jsonDecode(response.data)['message'] as String;
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteNote(String id) async {
    final response = await _dio.delete('${dotenv.env['API_URL']}/notes/$id');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.data)['message'] as String;
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> editNote(String id, String title, String description) async {
    final response = await _dio.patch(
      '${dotenv.env['API_URL']}/notes/$id',
      data: {
        'title': title,
        'description': description,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.data)['message'] as String;
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NoteModel> getNoteById(String id) async {
    final response = await _dio.get('${dotenv.env['API_URL']}/notes/$id');

    if (response.statusCode == 200) {
      final result = NoteModel.fromJson(jsonDecode(response.data)['data']);
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    final response = await _dio.get('${dotenv.env['API_URL']}/notes');

    if (response.statusCode == 200) {
      final result = NoteResponse.fromJson(jsonDecode(response.data)).notes;
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NoteModel>> searchNotes(String query) {
    // TODO: implement searchNotes
    throw UnimplementedError();
  }
}
