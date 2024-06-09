import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/common/exceptions.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/common/network_info.dart';
import 'package:viapulsa_test/data/datasources/note_local_datasource.dart';
import 'package:viapulsa_test/data/datasources/note_remote_datasource.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource _remoteDataSource;
  final NoteLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  const NoteRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
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
        await _localDataSource.clearCacheNotes();

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
        await _localDataSource.clearCacheNotes();

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
        await _localDataSource.clearCacheNotes();

        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      debugPrint('local');
      final result = await _localDataSource.getCachedNotes();
      return Right(result.map((model) => model.toEntity()).toList());
    } on CacheException {
      debugPrint('remote');
      if (await _networkInfo.isConnected) {
        try {
          final result = await _remoteDataSource.getNotes();
          await _localDataSource.cacheNotes(result);

          return Right(result.map((model) => model.toEntity()).toList());
        } on ServerException {
          return const Left(ServerFailure(''));
        }
      } else {
        return const Left(ConnectionFailure(Constants.noNetworkMsg));
      }
    }
  }

  @override
  Future<Either<Failure, List<Note>>> searchNotes(String query) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.searchNotes(query);
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure(Constants.noNetworkMsg));
    }
  }
}
