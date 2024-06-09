import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/search_notes_cubit.dart';
import 'package:viapulsa_test/presentation/pages/note_detail_page.dart';
import 'package:viapulsa_test/presentation/widgets/app_textfield.dart';
import 'package:viapulsa_test/presentation/widgets/fill_remaining_layout.dart';
import 'package:viapulsa_test/presentation/widgets/note_item.dart';

class SearchPage extends StatefulWidget {
  static const path = '/search';
  static const route = 'search-page';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? debounce;
  late final TextEditingController searchController;

  void _onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchController.value = TextEditingValue(text: query);
        context.read<SearchNotesCubit>().searchNotes(searchController.text);
      });
    });
  }

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title: Row(
            children: [
              Expanded(
                child: AppTextField(
                  hintText: 'Search Here',
                  controller: searchController,
                  onChanged: _onSearchChanged,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 21,
                    color: AppColors.grey,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.white,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 4),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: context.pop,
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.red,
                        letterSpacing: 0,
                      ),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<SearchNotesCubit, SearchNotesState>(
            builder: (context, state) {
              if (state is SearchNotesLoading) {
                return const FillRemainingLayout(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is SearchNotesLoaded) {
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
              } else if (state is SearchNotesFailed) {
                return FillRemainingLayout(
                  child: Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              } else if (state is SearchNotesInitial &&
                  searchController.text.isNotEmpty) {
                return FillRemainingLayout(
                  child: Center(
                    child: Text(
                      'Note tidak ditemukan',
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
