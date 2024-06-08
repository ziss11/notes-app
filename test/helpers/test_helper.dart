import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

@GenerateMocks([
  NoteRepository,
], customMocks: [
  MockSpec<Dio>(as: #MockDio)
])
void main() {}
