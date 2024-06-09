import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/domain/entities/note.dart';
import 'package:viapulsa_test/presentation/cubit/delete_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/edit_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
import 'package:viapulsa_test/presentation/widgets/note_desc_textfield.dart';
import 'package:viapulsa_test/presentation/widgets/note_title_textfield.dart';

class NoteDetailPage extends StatefulWidget {
  static const path = '/detail';
  static const route = 'detail-page';

  final Note note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController descController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note.title);
    descController = TextEditingController(text: widget.note.description);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  void updateNote() {
    if (formKey.currentState!.validate()) {
      context
          .read<EditNoteCubit>()
          .editNote(widget.note.id, titleController.text, descController.text);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void deleteNote() {
    context.read<DeleteNoteCubit>().deleteNote(widget.note.id);
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
          actions: [
            BlocConsumer<EditNoteCubit, EditNoteState>(
              listener: (context, state) {
                if (state is EditNoteSuccess) {
                  context.read<NotesCubit>().fetchNotes();
                }
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: (state is! DeleteNoteLoading) ? updateNote : null,
                  child: (state is EditNoteLoading)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        )
                      : Text(
                          'Done',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.green,
                                    letterSpacing: 0,
                                  ),
                        ),
                );
              },
            ),
            BlocConsumer<DeleteNoteCubit, DeleteNoteState>(
              listener: (context, state) {
                if (state is DeleteNoteSuccess) {
                  context.read<NotesCubit>().fetchNotes();
                  context.pop();
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: (state is! DeleteNoteLoading) ? deleteNote : null,
                  icon: (state is DeleteNoteLoading)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        )
                      : const Icon(
                          Icons.delete_outline,
                          color: AppColors.red,
                        ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  NoteTitleTextField(
                    controller: titleController,
                    validator: FormBuilderValidators.required(
                        errorText: 'Title is required'),
                  ),
                  const SizedBox(height: 10),
                  NoteDescTextField(
                    controller: descController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
