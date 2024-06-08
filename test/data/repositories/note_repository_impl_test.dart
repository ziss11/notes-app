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
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockNoteRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NoteRepositoryImpl(
      mockRemoteDataSource,
      mockNetworkInfo,
    );
  });

  const tId = 'id';
  const tNoteTitle = 'title';
  const tNoteDescription = 'description';

  group('Get Notes', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNotes()).thenAnswer((_) async => []);
      // act
      await repository.getNotes();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

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
    });

    group('when the device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return connetion failure when the device not connected to internet',
          () async {
        // act
        final result = await repository.getNotes();
        // assert
        expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
      });
    });
  });

  group('Get Note By Id', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNoteById(tId))
          .thenAnswer((_) async => tNoteModel);
      // act
      await repository.getNoteById(tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

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
        when(mockRemoteDataSource.getNoteById(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getNoteById(tId);
        // assert
        verify(mockRemoteDataSource.getNoteById(tId));
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('when the device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return connetion failure when the device not connected to internet',
          () async {
        // act
        final result = await repository.getNoteById(tId);
        // assert
        expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
      });
    });
  });

  group('Add Note', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addNote(tNoteTitle, tNoteDescription))
          .thenAnswer((_) async => Constants.successAddNoteMsg);
      // act
      await repository.addNote(tNoteTitle, tNoteDescription);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

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
    });

    group('when the device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return connetion failure when the device not connected to internet',
          () async {
        // act
        final result = await repository.addNote(tNoteTitle, tNoteDescription);
        // assert
        expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
      });
    });
  });

  group('Edit Note', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription))
          .thenAnswer((_) async => Constants.successEditNoteMsg);
      // act
      await repository.editNote(tId, tNoteTitle, tNoteDescription);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

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
        verify(
            mockRemoteDataSource.editNote(tId, tNoteTitle, tNoteDescription));
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('when the device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return connetion failure when the device not connected to internet',
          () async {
        // act
        final result =
            await repository.editNote(tId, tNoteTitle, tNoteDescription);
        // assert
        expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
      });
    });
  });

  group('Delete Note', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteNote(tId))
          .thenAnswer((_) async => Constants.successDeleteNoteMsg);
      // act
      await repository.deleteNote(tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

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
    });

    group('when the device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return connetion failure when the device not connected to internet',
          () async {
        // act
        final result = await repository.deleteNote(tId);
        // assert
        expect(result, const Left(ConnectionFailure(Constants.noNetworkMsg)));
      });
    });
  });
}
