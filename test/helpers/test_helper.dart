import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:viapulsa_test/data/datasources/note_remote_datasource.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

@GenerateMocks([
  NoteRepository,
  NoteRemoteDataSource,
], customMocks: [
  MockSpec<Dio>(as: #MockDio)
])
void main() {}
