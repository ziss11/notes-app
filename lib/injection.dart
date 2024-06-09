import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:viapulsa_test/common/network_info.dart';
import 'package:viapulsa_test/data/datasources/db/database_helper.dart';
import 'package:viapulsa_test/data/datasources/note_local_datasource.dart';
import 'package:viapulsa_test/data/datasources/note_remote_datasource.dart';
import 'package:viapulsa_test/data/repositories/note_repository_impl.dart';
import 'package:viapulsa_test/domain/repositories/note_repository.dart';
import 'package:viapulsa_test/domain/usecases/add_note.dart';
import 'package:viapulsa_test/domain/usecases/delete_note.dart';
import 'package:viapulsa_test/domain/usecases/edit_note.dart';
import 'package:viapulsa_test/domain/usecases/get_note_by_id.dart';
import 'package:viapulsa_test/domain/usecases/get_notes.dart';
import 'package:viapulsa_test/domain/usecases/search_notes.dart';
import 'package:viapulsa_test/presentation/cubit/add_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/delete_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/edit_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/note_detail_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/search_notes_cubit.dart';

class Injection {
  Injection._();

  static void init() {
    // Cubit
    GetIt.I.registerFactory<NotesCubit>(() => NotesCubit(GetIt.I()));
    GetIt.I.registerFactory<NoteDetailCubit>(() => NoteDetailCubit(GetIt.I()));
    GetIt.I
        .registerFactory<SearchNotesCubit>(() => SearchNotesCubit(GetIt.I()));
    GetIt.I.registerFactory<AddNoteCubit>(() => AddNoteCubit(GetIt.I()));
    GetIt.I.registerFactory<EditNoteCubit>(() => EditNoteCubit(GetIt.I()));
    GetIt.I.registerFactory<DeleteNoteCubit>(() => DeleteNoteCubit(GetIt.I()));

    // Use Cases
    GetIt.I.registerLazySingleton<GetNotes>(() => GetNotes(GetIt.I()));
    GetIt.I.registerLazySingleton<GetNoteById>(() => GetNoteById(GetIt.I()));
    GetIt.I.registerLazySingleton<SearchNotes>(() => SearchNotes(GetIt.I()));
    GetIt.I.registerLazySingleton<AddNote>(() => AddNote(GetIt.I()));
    GetIt.I.registerLazySingleton<EditNote>(() => EditNote(GetIt.I()));
    GetIt.I.registerLazySingleton<DeleteNote>(() => DeleteNote(GetIt.I()));

    // Repositories
    GetIt.I.registerLazySingleton<NoteRepository>(
        () => NoteRepositoryImpl(GetIt.I(), GetIt.I(), GetIt.I()));

    // Data Sources
    GetIt.I.registerLazySingleton<NoteRemoteDataSource>(
        () => NoteRemoteDataSourceImpl(GetIt.I()));
    GetIt.I.registerLazySingleton<NoteLocalDataSource>(
        () => NoteLocalDataSourceImpl(GetIt.I()));

    // External
    GetIt.I.registerLazySingleton<Dio>(() => Dio());
    GetIt.I.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
    GetIt.I
        .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(GetIt.I()));
    GetIt.I.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
  }
}
