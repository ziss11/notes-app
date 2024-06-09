import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:viapulsa_test/common/app_colors.dart';
import 'package:viapulsa_test/presentation/cubit/add_note_cubit.dart';
import 'package:viapulsa_test/presentation/cubit/notes_cubit.dart';
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
  final formKey = GlobalKey<FormState>();

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

  void createNote() {
    if (formKey.currentState!.validate()) {
      context
          .read<AddNoteCubit>()
          .addNote(titleController.text, descController.text);
      FocusScope.of(context).requestFocus(FocusNode());
    }
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
            BlocConsumer<AddNoteCubit, AddNoteState>(
              listener: (context, state) {
                if (state is AddNoteSuccess) {
                  context.read<NotesCubit>().fetchNotes();
                }
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: (state is! AddNoteLoading) ? createNote : null,
                  child: (state is AddNoteLoading)
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
