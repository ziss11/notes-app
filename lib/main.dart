import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/common/router.dart';
import 'package:viapulsa_test/injection.dart';
import 'package:viapulsa_test/presentation/cubit/add_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/delete_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/edit_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/search_notes_cubit.dart';

void main() async {
  await dotenv.load();

  Injection.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<NotesCubit>()),
        BlocProvider(create: (_) => GetIt.I<SearchNotesCubit>()),
        BlocProvider(create: (_) => GetIt.I<AddNoteCubit>()),
        BlocProvider(create: (_) => GetIt.I<EditNoteCubit>()),
        BlocProvider(create: (_) => GetIt.I<DeleteNoteCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SofiaPro',
          scaffoldBackgroundColor: AppColors.black,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.black,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.purpleBlue,
            elevation: 0,
          ),
        ),
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
