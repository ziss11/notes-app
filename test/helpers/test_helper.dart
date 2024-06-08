import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:viapulsa_test/common/network_info.dart';
import 'package:viapulsa_test/data/datasources/db/database_helper.dart';
import 'package:viapulsa_test/data/datasources/note_local_datasource.dart';
import 'package:viapulsa_test/data/datasources/note_remote_datasource.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

@GenerateMocks([
  NoteRepository,
  NoteRemoteDataSource,
  NoteLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<Dio>(as: #MockDio)
])
void main() {}
