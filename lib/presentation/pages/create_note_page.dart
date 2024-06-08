import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/widgets/note_desc_textfield.dart';
import 'package:viapulsa_test/presentation/widgets/note_title_textfield.dart';

class CreateNotePage extends StatefulWidget {
  static const path = '/create';
  static const route = 'create-note-page';

  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  late final TextEditingController titleController;
  late final TextEditingController descController;

  @override
  void initState() {
    titleController = TextEditingController();
    descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.clear,
              color: AppColors.grey,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                NoteTitleTextField(
                  controller: titleController,
                ),
                const SizedBox(height: 4),
                NoteDescTextField(
                  controller: descController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
