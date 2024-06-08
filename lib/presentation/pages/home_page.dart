import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/pages/create_note_page.dart';
import 'package:viapulsa_test/presentation/pages/note_detail_page.dart';
import 'package:viapulsa_test/presentation/widgets/app_textfield.dart';
import 'package:viapulsa_test/presentation/widgets/note_item.dart';

class HomePage extends StatefulWidget {
  static const path = '/';
  static const route = 'home-page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? debounce;
  late final TextEditingController searchController;

  void _onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchController.value = TextEditingValue(text: query);
        debugPrint('Search Query: ${searchController.text}');
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
          title: Text(
            'Notes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed(CreateNotePage.route),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: ListView.separated(
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              return NoteItem(
                onTap: () {
                  context.pushNamed(NoteDetailPage.route);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
