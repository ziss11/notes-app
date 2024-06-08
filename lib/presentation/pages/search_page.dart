import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/widgets/app_textfield.dart';

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
    return Scaffold(
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
    );
  }
}
