import 'package:get_it/get_it.dart';
import 'package:viapulsa_test/presentation/cubit/add_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/delete_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/edit_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/search_notes_cubit.dart';

class Injection {
  Injection._();

  static void init() {
    // Cubit
    GetIt.I.registerFactory(() => NotesCubit(GetIt.I()));
    GetIt.I.registerFactory(() => SearchNotesCubit(GetIt.I()));
    GetIt.I.registerFactory(() => AddNoteCubit(GetIt.I()));
    GetIt.I.registerFactory(() => EditNoteCubit(GetIt.I()));
    GetIt.I.registerFactory(() => DeleteNoteCubit(GetIt.I()));
  }
}
