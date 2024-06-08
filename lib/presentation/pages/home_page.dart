import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/pages/create_note_page.dart';
import 'package:viapulsa_test/presentation/pages/note_detail_page.dart';
import 'package:viapulsa_test/presentation/pages/search_page.dart';
import 'package:viapulsa_test/presentation/widgets/app_textfield.dart';
import 'package:viapulsa_test/presentation/widgets/note_item.dart';

class HomePage extends StatelessWidget {
  static const path = '/';
  static const route = 'home-page';

  const HomePage({super.key});

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
              Text(
                '15 Notes',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(letterSpacing: 0),
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
          child: ListView.separated(
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
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
