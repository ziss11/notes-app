import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viapulsa_test/common/constants.dart';
import 'package:viapulsa_test/common/exceptions.dart';
import 'package:viapulsa_test/common/failures.dart';
import 'package:viapulsa_test/data/repositories/note_repository_impl.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NoteRepositoryImpl repository;
  late MockNoteRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockNoteRemoteDataSource();
    repository = NoteRepositoryImpl(mockRemoteDataSource);
  });

  const tId = 'id';
  const tNoteTitle = 'title';
  const tNoteDescription = 'description';

  group('Get Notes', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNotes())
          .thenAnswer((_) async => tNoteModels);
      // act
      final result = await repository.getNotes();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tNotes);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNotes()).thenThrow(ServerException());
      // act
      final result = await repository.getNotes();
      // assert
      verify(mockRemoteDataSource.getNotes());
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connetion failure when the device not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNotes())
          .thenThrow(const SocketException(Constants.noNetworkMsg));
      // act
      final result = await repository.getNotes();
      // assert
      verify(mockRemoteDataSource.getNotes());
      expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
    });
  });

  group('Get Note By Id', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNoteById(tId))
          .thenAnswer((_) async => tNoteModel);
      // act
      final result = await repository.getNoteById(tId);
      // assert
      expect(result, Right(tNote));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNoteById(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getNoteById(tId);
      // assert
      verify(mockRemoteDataSource.getNoteById(tId));
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connetion failure when the device not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNoteById(tId))
          .thenThrow(const SocketException(Constants.noNetworkMsg));
      // act
      final result = await repository.getNoteById(tId);
      // assert
      verify(mockRemoteDataSource.getNoteById(tId));
      expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
    });
  });

  group('Add Note', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.addNote(tNoteTitle, tNoteDescription))
          .thenAnswer((_) async => Constants.successAddNoteMsg);
      // act
      final result = await repository.addNote(tNoteTitle, tNoteDescription);
      // assert
      expect(result, const Right(Constants.successAddNoteMsg));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.addNote(tNoteTitle, tNoteDescription))
          .thenThrow(ServerException());
      // act
      final result = await repository.addNote(tNoteTitle, tNoteDescription);
      // assert
      verify(mockRemoteDataSource.addNote(tNoteTitle, tNoteDescription));
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connetion failure when the device not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.addNote(tNoteTitle, tNoteDescription))
          .thenThrow(const SocketException(Constants.noNetworkMsg));
      // act
      final result = await repository.addNote(tNoteTitle, tNoteDescription);
      // assert
      verify(mockRemoteDataSource.addNote(tNoteTitle, tNoteDescription));
      expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
    });
  });

  group('Edit Note', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription))
          .thenAnswer((_) async => Constants.successAddNoteMsg);
      // act
      final result =
          await repository.editNote(tId, tNoteTitle, tNoteDescription);
      // assert
      expect(result, const Right(Constants.successAddNoteMsg));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription))
          .thenThrow(ServerException());
      // act
      final result =
          await repository.editNote(tId, tNoteTitle, tNoteDescription);
      // assert
      verify(mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription));
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connetion failure when the device not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription))
          .thenThrow(const SocketException(Constants.noNetworkMsg));
      // act
      final result =
          await repository.editNote(tId, tNoteTitle, tNoteDescription);
      // assert
      verify(mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription));
      expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
    });
  });

  group('Delete Note', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.deleteNote(tId))
          .thenAnswer((_) async => Constants.successAddNoteMsg);
      // act
      final result = await repository.deleteNote(tId);
      // assert
      expect(result, const Right(Constants.successAddNoteMsg));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.deleteNote(tId)).thenThrow(ServerException());
      // act
      final result = await repository.deleteNote(tId);
      // assert
      verify(mockRemoteDataSource.deleteNote(tId));
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connetion failure when the device not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.deleteNote(tId))
          .thenThrow(const SocketException(Constants.noNetworkMsg));
      // act
      final result = await repository.deleteNote(tId);
      // assert
      verify(mockRemoteDataSource.deleteNote(tId));
      expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
    });
  });
}
