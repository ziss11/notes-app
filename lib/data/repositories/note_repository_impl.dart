import 'package:dartz/dartz.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/common/exceptions.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/common/network_info.dart';
import 'package:viapulsa_test/data/datasources/note_remote_datasource.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const NoteRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, String>> addNote(
    String title,
    String description,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.addNote(title, description);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }

  @override
  Future<Either<Failure, String>> deleteNote(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.deleteNote(id);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }

  @override
  Future<Either<Failure, String>> editNote(
    String id,
    String title,
    String description,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.editNote(id, title, description);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }

  @override
  Future<Either<Failure, Note>> getNoteById(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.getNoteById(id);
        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.getNotes();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }
}
