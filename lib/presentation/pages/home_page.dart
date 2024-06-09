import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
import 'package:viapulsa_test/presentation/pages/create_note_page.dart';
import 'package:viapulsa_test/presentation/pages/note_detail_page.dart';
import 'package:viapulsa_test/presentation/pages/search_page.dart';
import 'package:viapulsa_test/presentation/widgets/app_textfield.dart';
import 'package:viapulsa_test/presentation/widgets/fill_remaining_layout.dart';
import 'package:viapulsa_test/presentation/widgets/note_item.dart';

class HomePage extends StatefulWidget {
  static const path = '/';
  static const route = 'home-page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() => context.read<NotesCubit>().fetchNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: GestureDetector(
                onTap: () => context.pushNamed(SearchPage.route),
                child: const AppTextField(
                  enabled: false,
                  hintText: 'Search Here',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 21,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.darkGrey,
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 50),
              const Spacer(),
              BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  if (state is AllNotesLoaded) {
                    return Text(
                      '${state.notes.length} Notes',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(letterSpacing: 0),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.pushNamed(CreateNotePage.route),
                icon: const Icon(
                  Icons.create,
                  size: 20,
                  color: AppColors.purpleBlue,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              if (state is AllNotesLoading) {
                return const FillRemainingLayout(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is AllNotesLoaded) {
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<NotesCubit>().fetchNotes();
                  },
                  child: ListView.separated(
                    itemCount: state.notes.length,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 14);
                    },
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      return NoteItem(
                        note: note,
                        onTap: () {
                          context.pushNamed(NoteDetailPage.route);
                        },
                      );
                    },
                  ),
                );
              } else if (state is AllNotesFailed) {
                return FillRemainingLayout(
                  child: Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              } else if (state is AllNotesInitial) {
                return FillRemainingLayout(
                  child: Center(
                    child: Text(
                      'Tidak ada Note',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
